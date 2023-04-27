import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/features/auth/login/widgets/nextfloatingbutton.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';

class LoginPassword extends StatefulWidget {
  const LoginPassword({super.key});

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      floatingActionButton: InkWell(
          onTap: () {
            if (passwordController.text.isEmpty) {
              context.showSnackBar(context, msg: "Please Enter Password");
            } else if (passwordController.text.length < 8) {
              context.showSnackBar(context,
                  msg: "Minimum 8 Characters Required ");
            } else {
              AppEnvironment.navigator.pushNamed(AuthRoutes.signup);
            }
          },
          child: NextFloatingButton()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                Text("Welcome back, Signin to\ncontinue",
                    style: AppText.text22w500.copyWith(
                      color: Colors.black,
                    )),
                sizedBoxWithHeight(80),
                Container(
                  color: Colors.grey.shade300,
                  child: TextFormField(
                    controller: passwordController,
                    cursorColor: AppColors.grey500,
                    obscureText: true,
                    decoration: InputDecoration(
                        isDense: true,
                        // fillColor: Colors.grey.shade300,
                        // filled: true,

                        hintText: "Enter password",
                        hintStyle: GoogleFonts.nunito(
                          color: Colors.black,
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
                        ))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Forgot Password?",
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
