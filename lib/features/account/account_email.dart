import 'package:flutter/material.dart';
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
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 40.w,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.account,
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            sizedBoxWithHeight(
              40,
            ),
            Text(
              Strings.email,
              style: GoogleFonts.poppins(
                color: AppColors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            sizedBoxWithHeight(
              10,
            ),
            Text(
              Strings.persnolizeyourexp,
              style: GoogleFonts.poppins(
                  color: AppColors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300),
            ),
            sizedBoxWithHeight(
              20,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.greylight,
                border: Border.all(
                  color: AppColors.black,
                ),
              ),
              child: TextFormField(
                cursorColor: AppColors.grey500,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w300,
                ),
                controller: TextEditingController(
                  text: Strings.dummyemail,
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
                  Strings.update,
                  style: AppText.text15w500.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.green,
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
