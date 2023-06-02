import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';

class AccountChangePassword extends StatefulWidget {
  const AccountChangePassword({
    super.key,
  });

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
              Strings.newpassword,
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
              Strings.passwordtext,
              style: GoogleFonts.poppins(
                  color: AppColors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300),
            ),
            sizedBoxWithHeight(
              15,
            ),
            Text(
              Strings.newpassword,
              style: AppText.text15Normal.copyWith(
                color: AppColors.black,
                fontSize: 14.sp,
              ),
            ),
            sizedBoxWithHeight(
              5,
            ),
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
                        color: AppColors.black,
                      )),
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            sizedBoxWithHeight(
              15,
            ),
            Text(
              Strings.confirmpassword,
              style: AppText.text15Normal.copyWith(
                color: AppColors.black,
                fontSize: 14.sp,
              ),
            ),
            sizedBoxWithHeight(
              5,
            ),
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
                        color: AppColors.black,
                      )),
                  isDense: true,
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
