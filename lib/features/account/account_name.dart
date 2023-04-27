import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/features/add_member/add_member.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';

import '../../themes/app_text.dart';

class AccountName extends StatefulWidget {
  const AccountName({super.key});

  @override
  State<AccountName> createState() => _AccountNameState();
}

class _AccountNameState extends State<AccountName> {
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
              "Name",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            sizedBoxWithHeight(10),
            Text(
              "Let us know how to properly address you",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300),
            ),
            sizedBoxWithHeight(20),
            CommonTextField(
              title: "First Name",
              controller: TextEditingController(
                text: "Harry",
              ),
            ),
            sizedBoxWithHeight(15),
            CommonTextField(
              title: "Last Name",
              controller: TextEditingController(
                text: "Clinton",
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
