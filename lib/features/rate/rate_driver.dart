import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';

import '../../shared/ui/common/app_image.dart';
import '../../themes/app_text.dart';

class RateDriver extends StatefulWidget {
  const RateDriver({super.key});

  @override
  State<RateDriver> createState() => _RateDriverState();
}

class _RateDriverState extends State<RateDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        leading: InkWell(
            onTap: () {},
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.green,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Thank You",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  sizedBoxWithHeight(15),
                  AppImage(
                    Images.driver,
                    height: 70.h,
                    width: 70.w,
                  ),
                  sizedBoxWithHeight(15),
                  RatingBar.builder(
                    initialRating: 3.4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    ignoreGestures: true,
                    allowHalfRating: true,
                    unratedColor: Colors.white,
                    itemCount: 5,
                    itemSize: 19,
                    itemPadding: EdgeInsets.symmetric(
                      horizontal: 3,
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
                  sizedBoxWithHeight(15),
                  Text(
                    "We are glad you liked the trip!",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  sizedBoxWithHeight(15),
                  Text(
                    "Any comments?",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  sizedBoxWithHeight(65),
                ],
              ),
            ),
          ),
          ColumnSuper(
            innerDistance: -200,
            children: [
              Container(
                margin: EdgeInsets.only(
                      top: 100.h,
                    ) +
                    EdgeInsets.symmetric(
                      horizontal: 16.w,
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
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.greylight,
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4))
                    ]),
                clipBehavior: Clip.antiAlias,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Type your message hear ...",
                    hintStyle: GoogleFonts.poppins(
                      color: AppColors.hintColor,
                      fontSize: 12.sp,
                    ),
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
