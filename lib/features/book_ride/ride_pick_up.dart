import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/themes/app_text.dart';

class RidePickup extends StatefulWidget {
  const RidePickup({super.key});

  @override
  State<RidePickup> createState() => _RidePickupState();
}

class _RidePickupState extends State<RidePickup> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              markers: <Marker>{
                Marker(
                  markerId: const MarkerId('marker_1'),
                  draggable: true,
                  onDrag: (values) {
                    //    value.ondrag(values);
                  },
                  position: LatLng(
                    37.42796133580664,
                    -122.085749655962,
                  ),
                  infoWindow: const InfoWindow(
                      title: 'Marker Title', snippet: 'Marker Snippet'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                ),
              },
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              onMapCreated: (controller) {
                mapController = controller;

                mapController.moveCamera(
                  CameraUpdate.newLatLng(
                    LatLng(
                      37.42796133580664,
                      -122.085749655962,
                    ),
                  ),
                );
                mapController.animateCamera(
                  CameraUpdate.newLatLng(
                    LatLng(
                      37.42796133580664,
                      -122.085749655962,
                    ),
                  ),
                );

                // setState(() {
                //   ismapCreated = true;
                // });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  37.42796133580664,
                  -122.085749655962,
                ),
                zoom: 15.0,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 500.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Confirm your pickup spot",
                        style: AppText.text14w400.copyWith(
                            color: Color(
                              0xff2222222,
                            ),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Divider(
                      color: AppColors.greylight,
                      thickness: 1.4,
                    ),
                    Spacer(),
                    Text(
                      "1217 Islington Ave",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                      ),
                      child: Center(
                        child: Text(
                          "Confirm ride",
                          style: AppText.text15Normal
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                  ],
                ),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
