import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:multitrip_user/features/auth/login/logic/auth_controller.dart';
import 'package:multitrip_user/features/auth/login/widgets/nextfloatingbutton.dart';
import 'package:multitrip_user/features/common/splashbackground.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';
import 'package:provider/provider.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  Country country = Country(
    phoneCode: "+1",
    countryCode: "CA",
    e164Sc: 1,
    geographic: false,
    level: 1,
    name: "CANADA",
    example: "",
    displayName: "Canada",
    displayNameNoCountryCode: "",
    e164Key: "",
  );

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authcontroller = Provider.of<AuthController>(context);

    return Scaffold(
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: InkWell(
          onTap: () async {
            if (authcontroller.phoneController.text.isEmpty) {
              context.showSnackBar(context, msg: "Please enter mobile number");
            } else if (authcontroller.phoneController.text.length > 11) {
              context.showSnackBar(context,
                  msg: "number should be 11 Characters long");
            } else {
              authcontroller.douserlogin(context: context);
              // AppEnvironment.navigator.pushNamed(
              //   AuthRoutes.otplogin,
              // );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NextFloatingButton(),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.appColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SplashBackground(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter your mobile number",
                        style: AppText.text22w500.copyWith(
                          color: Colors.black,
                        )),
                    sizedBoxWithHeight(15),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode:
                                  true, // optional. Shows phone code before the country name.
                              onSelect: (Country scountry) {
                                setState(() {
                                  country = scountry;
                                  log(scountry.name + scountry.countryCode);
                                });
                              },
                            );
                          },
                          child: Container(
                            width: 65.w,
                            height: 40.h,
                            color: AppColors.mobilegrey,
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  country.flagEmoji,
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                sizedBoxWithWidth(10),
                                Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        sizedBoxWithWidth(10),
                        Expanded(
                          child: Container(
                              height: 40.h,
                              padding: EdgeInsets.only(left: 10.w),
                              child: Row(
                                children: [
                                  Text(country.phoneCode,
                                      style: AppText.text15Normal.copyWith(
                                        color: Colors.black,
                                      )),
                                  sizedBoxWithWidth(10),
                                  Expanded(
                                    child: Form(
                                      key: _formkey,
                                      child: TextFormField(
                                        maxLength: 11,
                                        cursorColor: AppColors.grey500,
                                        controller:
                                            authcontroller.phoneController,
                                        keyboardType: TextInputType.phone,
                                        style: AppText.text15Normal.copyWith(
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: '',
                                          isDense: true,
                                          hintText: " Mobile Number",
                                          hintStyle:
                                              AppText.text15Normal.copyWith(
                                            color: AppColors.hintColor,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              color: AppColors.mobilegrey),
                        ),
                      ],
                    ),
                    sizedBoxWithHeight(15),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 50.w,
                      ),
                      child: Text(
                          "By proceeding you are consenting to receive calls oe SMS messages, including by automated dialer from FCDD and its affiliates to the number you provide",
                          style: AppText.text15w400.copyWith(
                            color: AppColors.colorgrey,
                            fontSize: 13.sp,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
