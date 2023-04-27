import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/app_image.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';

import '../../themes/app_text.dart';

class BookingOTP extends StatefulWidget {
  const BookingOTP({super.key});

  @override
  State<BookingOTP> createState() => _BookingOTPState();
}

class _BookingOTPState extends State<BookingOTP> {
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Meet at your pickup spot",
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 45.h,
                          width: 45.h,
                          color: AppColors.green,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "1",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "min",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
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
                              "Sam",
                              style: AppText.text14w400.copyWith(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 3.4,
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
                            sizedBoxWithHeight(4),
                          ],
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.green,
                                AppColors.yellow,
                              ],
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 12.w,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.dialpad_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                              Text(
                                " OTP",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "   1199",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
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
