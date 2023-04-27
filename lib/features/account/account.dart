import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';

class Account extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;

  const Account({super.key, this.parentScaffoldKey});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
            AppEnvironment.navigator
                .pushReplacementNamed(GeneralRoutes.bottombar, arguments: 0);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Harry",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20.h,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 2.h,
                      ),
                      child: Row(children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 13,
                        ),
                        sizedBoxWithWidth(3),
                        Text(
                          "5.00",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ]),
                      decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    AppEnvironment.navigator
                        .pushNamed(GeneralRoutes.accountinfo);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            sizedBoxWithHeight(20),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 24.w,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.help,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text(
                        "Help",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(4)),
                ),
                sizedBoxWithWidth(10),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 10.w,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.access_time_filled_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text(
                        "Previous booking",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(4)),
                )
              ],
            ),
            sizedBoxWithHeight(40),
            Divider(
              thickness: 1.2,
              color: AppColors.greylight,
            ),
            sizedBoxWithHeight(40),
            Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                sizedBoxWithWidth(3),
                Text(
                  "Settings",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            sizedBoxWithHeight(10),
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.black,
                  size: 20,
                ),
                sizedBoxWithWidth(3),
                Text(
                  "Legal",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
            sizedBoxWithHeight(40),
            Divider(
              thickness: 1.2,
              color: AppColors.greylight,
            ),
            sizedBoxWithHeight(40),
            Text(
              "Total Spending - \$400.00",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp),
            ),
            sizedBoxWithHeight(10),
            Text(
              "Total miles drive - 50 miles",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp),
            )
          ],
        ),
      ),
    );
  }
}
