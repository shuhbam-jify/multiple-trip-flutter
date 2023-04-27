import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/features/add_member/add_member.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';

class AccountPhone extends StatefulWidget {
  const AccountPhone({super.key});

  @override
  State<AccountPhone> createState() => _AccountPhoneState();
}

class _AccountPhoneState extends State<AccountPhone> {
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
              "Phone Number",
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
            Row(
              children: [
                InkWell(
                  onTap: () {
                    print("fkf");
                    showCountryPicker(
                      context: context,
                      showPhoneCode:
                          true, // optional. Shows phone code before the country name.
                      onSelect: (Country scountry) {
                        setState(() {
                          country = scountry;
                        });
                      },
                    );
                  },
                  child: Container(
                    width: 65.w,
                    height: 50.h,
                    color: Colors.grey.shade300,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          country.flagEmoji,
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        sizedBoxWithWidth(5),
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
                    padding: EdgeInsets.only(left: 10.w),
                    child: Row(
                      children: [
                        Text(country.phoneCode,
                            style: AppText.text15Normal.copyWith(
                              color: Colors.black,
                            )),
                        sizedBoxWithWidth(10),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            maxLength: 11,
                            decoration: InputDecoration(
                              counterText: '',
                              hintText: "Mobile Number",
                              hintStyle: AppText.text15Normal.copyWith(
                                color: AppColors.hintColor,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
            sizedBoxWithHeight(10),
            Text(
              "A verification code will be sent to this number",
              style: GoogleFonts.poppins(
                color: AppColors.colorgrey,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
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
