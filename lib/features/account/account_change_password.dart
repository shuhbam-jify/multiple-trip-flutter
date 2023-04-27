import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';

class AccountChangePassword extends StatefulWidget {
  const AccountChangePassword({super.key});

  @override
  State<AccountChangePassword> createState() => _AccountChangePasswordState();
}

class _AccountChangePasswordState extends State<AccountChangePassword> {
  bool isconfirmvisible = false;
  bool ispasswordvisible = false;
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
              "New Password",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            sizedBoxWithHeight(10),
            Text(
              "Your passwords must be at least 8 characters long, and contain atleast one letter and one digit",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300),
            ),
            sizedBoxWithHeight(15),
            Text(
              "New password",
              style: AppText.text15Normal.copyWith(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
            sizedBoxWithHeight(5),
            Container(
              color: Colors.grey.shade300,
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                cursorColor: AppColors.grey500,
                obscureText: ispasswordvisible ? false : true,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            ispasswordvisible = !ispasswordvisible;
                          });
                        },
                        child: Icon(
                          ispasswordvisible
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_rounded,
                          color: Colors.black,
                        )),
                    isDense: true,
                    // fillColor: Colors.grey.shade300,
                    // filled: true,

                    border: InputBorder.none),
              ),
            ),
            sizedBoxWithHeight(15),
            Text(
              "Confirm new password",
              style: AppText.text15Normal.copyWith(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
            sizedBoxWithHeight(5),
            Container(
              color: Colors.grey.shade300,
              child: TextFormField(
                obscureText: isconfirmvisible ? false : true,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: AppColors.grey500,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isconfirmvisible = !isconfirmvisible;
                          });
                        },
                        child: Icon(
                          isconfirmvisible
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_rounded,
                          color: Colors.black,
                        )),
                    isDense: true,
                    border: InputBorder.none
                    // fillColor: Colors.grey.shade300,
                    // filled: true,
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
