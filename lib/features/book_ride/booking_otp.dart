import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multitrip_user/app_enverionment.dart';
import 'package:multitrip_user/features/book_ride/under_the_ride.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/app_image.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';

import '../../themes/app_text.dart';

class BookingOTP extends StatefulWidget {
  final LatLng pickuplatlong;
  final LatLng droplatlong;
  final Set<Polyline> polylines;
  const BookingOTP({
    required this.polylines,
    required this.droplatlong,
    required this.pickuplatlong,
    super.key,
  });

  @override
  State<BookingOTP> createState() => _BookingOTPState();
}

class _BookingOTPState extends State<BookingOTP> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              polylines: widget.polylines,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              markers: <Marker>{
                Marker(
                  markerId: const MarkerId('marker_1'),
                  draggable: false,
                  position: LatLng(
                    widget.droplatlong.latitude,
                    widget.droplatlong.longitude,
                  ),
                  infoWindow: const InfoWindow(
                    title: 'Marker Title',
                    snippet: 'Marker Snippet',
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
                ),
                Marker(
                  markerId: const MarkerId('marker_2'),
                  draggable: false,
                  position: LatLng(
                    widget.pickuplatlong.latitude,
                    widget.pickuplatlong.longitude,
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
                controller.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(
                      widget.pickuplatlong.latitude,
                      widget.pickuplatlong.longitude,
                    ),
                    15,
                  ),
                );
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.pickuplatlong.latitude,
                  widget.pickuplatlong.longitude,
                ),
                zoom: 15.0,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300.h,
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
                            color: AppColors.black,
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
                    sizedBoxWithHeight(
                      20,
                    ),
                    Row(
                      children: [
                        AppImage(
                          Images.driver,
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
                                color: AppColors.black,
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
                              itemPadding: EdgeInsets.symmetric(
                                horizontal: .0,
                              ),
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
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(
                        //       20,
                        //     ),
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         AppColors.green,
                        //         AppColors.yellow,
                        //       ],
                        //     ),
                        //   ),
                        //   padding: EdgeInsets.symmetric(
                        //     vertical: 8.h,
                        //     horizontal: 15.w,
                        //   ),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Icon(
                        //         Icons.dialpad_rounded,
                        //         size: 18,
                        //         color: Colors.white,
                        //       ),
                        //       Text(
                        //         " OTP",
                        //         style: GoogleFonts.poppins(
                        //           color: Colors.white,
                        //           fontSize: 14.sp,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //       Text(
                        //         "   1199",
                        //         style: GoogleFonts.poppins(
                        //           color: Colors.white,
                        //           fontSize: 14.sp,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            AppEnvironment.navigator.push(
                              MaterialPageRoute(
                                builder: (context) => UnderTheRide(
                                  droplatlong: widget.droplatlong,
                                  pickuplatlong: widget.pickuplatlong,
                                  polylines: widget.polylines,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 10.w,
                            ),
                            child: Icon(
                              Icons.phone_in_talk_sharp,
                              color: AppColors.black,
                              size: 20,
                            ),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.greylight,
                              shape: BoxShape.circle,
                            ),
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
