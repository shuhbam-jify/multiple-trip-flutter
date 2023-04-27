import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multitrip_user/models/neardrivers.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/app_image.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';

class SelectRider extends StatefulWidget {
  const SelectRider({super.key});

  @override
  State<SelectRider> createState() => _SelectRiderState();
}

class _SelectRiderState extends State<SelectRider> {
  late GoogleMapController mapController;
  List<NearDrivers> neardrivers = [
    NearDrivers(
      name: "Sam",
      price: "40",
      rating: 4,
      distance: 3.toString(),
      time: 5.toString(),
    ),
    NearDrivers(
        name: "Ram",
        price: "30",
        rating: 1.4,
        distance: 3.toString(),
        time: 5.toString()),
    NearDrivers(
        name: "Aam",
        price: "540",
        rating: 4.4,
        distance: 3.toString(),
        time: 5.toString()),
    NearDrivers(
        name: "Rahul",
        price: "140",
        rating: 2,
        distance: 3.toString(),
        time: 5.toString()),
    NearDrivers(
        name: "Test User",
        price: "80",
        rating: 5,
        distance: 3.toString(),
        time: 5.toString()),
    NearDrivers(
        name: "Test User",
        price: "80",
        rating: 5,
        distance: 3.toString(),
        time: 5.toString()),
    NearDrivers(
        name: "Test User",
        price: "80",
        rating: 5,
        distance: 3.toString(),
        time: 5.toString()),
    NearDrivers(
        name: "Test User",
        price: "80",
        rating: 5,
        distance: 3.toString(),
        time: 5.toString()),
  ];

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
            Container(
              height: 40.h,
              width: 40.w,
              margin: EdgeInsets.only(
                top: 10.h,
                left: 8.w,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 400.h,
                color: Colors.white,
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 16.w,
                    right: 16.w,
                    bottom: 20.h,
                  ),
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        AppImage(
                          "assets/driver.svg",
                          height: 50.h,
                          width: 50.w,
                        ),
                        sizedBoxWithWidth(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              neardrivers.elementAt(index).name,
                              style: AppText.text14w400.copyWith(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating:
                                  neardrivers.elementAt(index).rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              ignoreGestures: true,
                              allowHalfRating: true,
                              unratedColor: Colors.grey,
                              itemCount: 5,
                              itemSize: 15,
                              itemPadding: EdgeInsets.symmetric(horizontal: .0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 10,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            sizedBoxWithHeight(2),
                            Text(
                              "4:05pm, 3 min away",
                              style: AppText.text14w400.copyWith(
                                color: Colors.black,
                                fontSize: 11.sp,
                              ),
                            ),
                            sizedBoxWithHeight(4),
                          ],
                        ),
                        Spacer(),
                        Text(
                          "\$ ${neardrivers.elementAt(index).price}",
                          style: AppText.text14w400.copyWith(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        sizedBoxWithWidth(10),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.black,
                          size: 15,
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 0.9,
                      color: AppColors.greylight,
                    );
                  },
                  itemCount: neardrivers.length,
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
              Row(
                children: [
                  Icon(
                    Icons.money_outlined,
                    color: Colors.green.shade300,
                    size: 40.h,
                  ),
                  sizedBoxWithWidth(10),
                  Text(
                    "Cash",
                    style: AppText.text15Normal.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16.h,
                  )
                ],
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
                    style: AppText.text15Normal.copyWith(color: Colors.white),
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
        ),
      ),
    );
  }
}
