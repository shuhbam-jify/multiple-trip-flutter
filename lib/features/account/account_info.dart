import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  int selectedtab = 0;
  Widget _createTab(String text) {
    return Tab(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: AppColors.appColor,
        appBar: AppBar(
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80.h),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
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
                  DecoratedBox(
                    decoration: BoxDecoration(
                      //This is for background color
                      color: Colors.white.withOpacity(0.0),

                      //This is for bottom border that is needed
                      border: Border(
                          bottom: BorderSide(
                              color: AppColors.greylight, width: 6.sp)),
                    ),
                    child: TabBar(
                      padding: EdgeInsets.only(right: 100.w),
                      indicatorColor: AppColors.green,
                      // indicator: BoxDecoration(
                      //   color: Colors.greenAccent,
                      // ),

                      indicatorWeight: 6.sp,
                      labelPadding: EdgeInsets.all(0),
                      onTap: (v) {
                        setState(() {
                          selectedtab = v;
                        });
                      },
                      tabs: [
                        Container(
                          color: selectedtab == 0
                              ? AppColors.greylight
                              : Colors.transparent,
                          margin: EdgeInsets.only(
                            bottom: 0.h,
                          ),
                          child: _createTab("Account Info"),
                        ),
                        Container(
                            color: selectedtab == 1
                                ? AppColors.greylight
                                : Colors.transparent,
                            margin: EdgeInsets.only(
                              bottom: 0.h,
                            ),
                            child: _createTab("Security")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          padding: EdgeInsets.all(16),
          child: TabBarView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Info",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  sizedBoxWithHeight(15),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.55,
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            AppEnvironment.navigator.pop();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                    Center(
                                      child: Text(
                                        "Profile Photo",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.2,
                                      color: AppColors.greydark,
                                    ),
                                    Text(
                                      "Your profile photo is visible to everyone",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                        top: 15.h,
                                        bottom: 0.h,
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
                                        color: AppColors.green,
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        AppEnvironment.navigator.pop();
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(
                                          top: 0.h,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: AppText.text15w500.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 16.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.greydark,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: AppColors.greylight,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          });
                    },
                    child: Stack(
                      children: [
                        Container(
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          right: 6.0,
                          bottom: .0,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                )
                              ],
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 14,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  sizedBoxWithHeight(15),
                  Text(
                    "Basic Info",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  sizedBoxWithHeight(20),
                  InkWell(
                    onTap: () {
                      AppEnvironment.navigator
                          .pushNamed(GeneralRoutes.accounname);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        sizedBoxWithHeight(5),
                        Text(
                          "Harry",
                          style: GoogleFonts.poppins(
                            color: AppColors.colorgrey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Divider(
                          thickness: 1.2,
                          color: AppColors.greylight,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AppEnvironment.navigator
                          .pushNamed(GeneralRoutes.accounphone);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone number",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        sizedBoxWithHeight(5),
                        Row(
                          children: [
                            Text(
                              "+19999888777",
                              style: GoogleFonts.poppins(
                                color: AppColors.colorgrey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 14,
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1.2,
                          color: AppColors.greylight,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      AppEnvironment.navigator
                          .pushNamed(GeneralRoutes.accounemail);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        sizedBoxWithHeight(5),
                        Row(
                          children: [
                            Text(
                              "harrynew1234@gmail.com",
                              style: GoogleFonts.poppins(
                                color: AppColors.colorgrey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 14,
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1.2,
                          color: AppColors.greylight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Security",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  sizedBoxWithHeight(40),
                  Text(
                    "Logging in",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  sizedBoxWithHeight(20),
                  InkWell(
                    onTap: () {
                      AppEnvironment.navigator
                          .pushNamed(GeneralRoutes.accounchangepassword);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        sizedBoxWithHeight(5),
                        Text(
                          "*******",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Divider(
                          thickness: 1.2,
                          color: AppColors.greylight,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
