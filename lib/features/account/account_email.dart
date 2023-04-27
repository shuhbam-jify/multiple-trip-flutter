import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';

class AccountEmail extends StatefulWidget {
  const AccountEmail({super.key});

  @override
  State<AccountEmail> createState() => _AccountEmailState();
}

class _AccountEmailState extends State<AccountEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leadingWidth: 40.w,
        leading: InkWell(
          onTap: () {
            AppEnvironment.navigator.pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            sizedBoxWithHeight(40),
            Text(
              "Email",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            sizedBoxWithHeight(10),
            Text(
              "Personalize your experience",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300),
            ),
            sizedBoxWithHeight(20),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.greylight,
                  border: Border.all(color: Colors.black)),
              child: TextFormField(
                cursorColor: AppColors.grey500,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                controller: TextEditingController(
                  text: "harrynew1234@gmail.com",
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 15.h,
                bottom: 30.h,
              ),
              child: Center(
                child: Text(
                  "Update",
                  style: AppText.text15w500.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(
                  10.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
