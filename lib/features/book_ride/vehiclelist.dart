import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multitrip_user/features/book_ride/add_vehicle.dart';
import 'package:multitrip_user/features/book_ride/select_rider.dart';
import 'package:multitrip_user/logic/vehicle/vehicle_controller.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/app_image.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'package:widget_to_marker/widget_to_marker.dart';

class VehicleList extends StatefulWidget {
  final double pickuplat;
  final double pickuplong;
  final double droplat;
  final String bookingid;
  final String amount;

  final double droplong;
  const VehicleList({
    super.key,
    required this.droplat,
    required this.droplong,
    required this.amount,
    required this.bookingid,
    required this.pickuplat,
    required this.pickuplong,
  });

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  Uint8List? custommarker;
  Future<Uint8List> getBytesFromAsset(String path) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: pixelRatio.round() * 30);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  getmarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/pin-1-svgrepo-com.png');
    setState(() {
      custommarker = markerIcon;
    });
  }

  VehicleController controller = VehicleController();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        width: 2,
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  void makeLines() async {
    await polylinePoints
        .getRouteBetweenCoordinates(
      "AIzaSyD6MRqmdjtnIHn7tyDLX-qsjreaTkuzSCY",
      PointLatLng(widget.pickuplat, widget.pickuplong), //Starting LATLANG
      PointLatLng(widget.droplat, widget.droplong), //End LATLANG
      travelMode: TravelMode.driving,
    )
        .then((value) {
      value.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }).then((value) {
      addPolyLine();
    });
  }

  int selectedvalue = 0;
  String? vehicleid;
  Set<Marker> markers = {};

  initMarkers() async {
    markers = {};

    markers.add(
      Marker(
        markerId: const MarkerId('marker_2'),
        draggable: false,
        position: LatLng(
          widget.pickuplat,
          widget.pickuplong,
        ),
        infoWindow:
            const InfoWindow(title: 'Marker Title', snippet: 'Marker Snippet'),
        icon: await AppImage(
          "assets/person.svg",
          height: 60.h,
          width: 60.w,
        ).toBitmapDescriptor(
            logicalSize: const Size(150, 150), imageSize: const Size(150, 150)),
      ),
    );
    markers.add(
      Marker(
        markerId: const MarkerId('marker_1'),
        draggable: false,
        position: LatLng(
          widget.droplat,
          widget.droplong,
        ),
        infoWindow: const InfoWindow(
          title: 'Marker Title',
          snippet: 'Marker Snippet',
        ),
        icon: await AppImage(
          "assets/pin-1-svgrepo-com.png",
        ).toBitmapDescriptor(
            logicalSize: const Size(150, 150), imageSize: const Size(150, 150)),
      ),
    );

    setState(() {});
  }

  @override
  void initState() {
    controller = Provider.of<VehicleController>(context, listen: false);

    getmarker();
    controller.getvehicles(context: context);
    makeLines();
    initMarkers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              polylines: Set<Polyline>.of(polylines.values),
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              markers: markers,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              onMapCreated: (controller) {
                controller.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(
                      widget.pickuplat,
                      widget.pickuplong,
                    ),
                    15,
                  ),
                );
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.pickuplat,
                  widget.pickuplong,
                ),
                zoom: 15.0,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40.h,
                width: 40.w,
                margin: EdgeInsets.only(
                  top: 10.h,
                  left: 8.w,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300.h,
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.only(
                  top: 10.h,
                  left: 16.w,
                  bottom: 10.h,
                  right: 16.w,
                ),
                child: Consumer<VehicleController>(
                  builder: (context, value, child) {
                    if (value.isloading) {
                      Loader.show(context,
                          progressIndicator: CircularProgressIndicator(
                            color: AppColors.appColor,
                          ));
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          vehicleid = controller.vehicles!.vehicles
                              .elementAt(index)
                              .vehicleId;
                          return Slidable(
                            key: const ValueKey(0),

                            // The start action pane is the one at the left or the top side.
                            endActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              //  dismissible: DismissiblePane(onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (BuildContext context) async {
                                    controller.deletevehicle(
                                        context: context,
                                        vehicle_id: controller
                                            .vehicles!.vehicles
                                            .elementAt(index)
                                            .vehicleId);
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedvalue = index;
                                  vehicleid = controller.vehicles!.vehicles
                                      .elementAt(index)
                                      .vehicleId;
                                });
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: AppColors.greylight,
                                    backgroundImage: Svg(
                                      "assets/1299198.svg",
                                    ),
                                  ),
                                  sizedBoxWithWidth(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.vehicles!.vehicles
                                            .elementAt(index)
                                            .vehicleName,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp),
                                      ),
                                      Text(
                                        value.vehicles!.vehicles
                                            .elementAt(index)
                                            .vehicleNumber,
                                        style: GoogleFonts.poppins(
                                            color: AppColors.grey500,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp),
                                      ),
                                      Text(
                                        value.vehicles!.vehicles
                                            .elementAt(index)
                                            .vehicleType,
                                        style: GoogleFonts.poppins(
                                            color: AppColors.grey500,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Icon(
                                      Icons.circle,
                                      color: selectedvalue == index
                                          ? Colors.white
                                          : AppColors.black,
                                      size: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: value.vehicles!.vehicles.length,
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, -3),
              spreadRadius: 0,
              blurRadius: 4)
        ]),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 0.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddVehicle(),
                          ),
                        );
                      },
                      child: Text(
                        "Add Vehicle + ",
                        style: GoogleFonts.poppins(
                          color: AppColors.green,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (vehicleid == null) {
                    context.showSnackBar(context,
                        msg: "Please Add Atleast one Vehicle");
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectRider(
                          vehicleid: vehicleid!,
                          amount: widget.amount,
                          droplatlong: LatLng(widget.droplat, widget.droplong),
                          pickuplatlong:
                              LatLng(widget.pickuplat, widget.pickuplong),
                          polylines: Set<Polyline>.of(polylines.values),
                          bookingid: widget.bookingid,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 10.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                  ),
                  child: Center(
                    child: Text(
                      "Confirm ride",
                      style: AppText.text15Normal.copyWith(color: Colors.white),
                    ),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Vehicle {
  final String name;
  final String number;
  final String color;
  final String type;
  Vehicle({
    required this.color,
    required this.name,
    required this.number,
    required this.type,
  });
}
