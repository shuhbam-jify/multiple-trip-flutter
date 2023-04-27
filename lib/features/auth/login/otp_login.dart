import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/features/auth/login/logic/auth_controller.dart';
import 'package:multitrip_user/features/auth/login/widgets/nextfloatingbutton.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';
import 'package:provider/provider.dart';

class OtpLogin extends StatefulWidget {
  const OtpLogin({super.key});

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  @override
  Widget build(BuildContext context) {
    final authcontroller = Provider.of<AuthController>(context);

    return Scaffold(
      backgroundColor: AppColors.appColor,
      floatingActionButton: InkWell(
        onTap: () {
          if (authcontroller.otpController.text.isEmpty) {
            context.showSnackBar(context, msg: "Please Enter OTP");
          } else if (authcontroller.otpController.text.length != 4) {
            context.showSnackBar(context,
                msg: "OTP length should be 4 character");
          } else {
            authcontroller.verifyOTP(
              context: context,
            );
          }
        },
        child: NextFloatingButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxWithHeight(0),
                InkWell(
                  onTap: () {
                    AppEnvironment.navigator.pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                sizedBoxWithHeight(10),
                Text("Verify your phone number",
                    style: AppText.text22w500.copyWith(
                      color: Colors.black,
                    )),
                sizedBoxWithHeight(40),
                Text(
                  "Enter the 4-digit code sent to you",
                  style: AppText.text16w400.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
                sizedBoxWithHeight(15),
                Container(
                  color: Colors.grey.shade300,
                  child: TextFormField(
                    cursorColor: AppColors.grey500,
                    maxLength: 4,
                    controller: authcontroller.otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      isDense: true,
                      hintText: " Enter the OTP code",
                      hintStyle: GoogleFonts.nunito(
                        color: AppColors.hintColor,
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      )),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBoxWithHeight(20),
                Text(
                  "Resend code via SMS",
                  style: GoogleFonts.nunito(
                    color: Colors.blue.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
