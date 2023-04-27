import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/features/auth/login/logic/auth_controller.dart';
import 'package:multitrip_user/features/auth/login/widgets/nextfloatingbutton.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/themes/app_text.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final authcontroller = Provider.of<AuthController>(context);

    return Scaffold(
      backgroundColor: AppColors.appColor,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: InkWell(
            onTap: () {
              if (authcontroller.emailController.text.isValidEmail() == false) {
                context.showSnackBar(
                  context,
                  msg: "Please Enter Valid Email",
                );
              } else if (authcontroller.passwordController.text.isEmpty) {
                context.showSnackBar(context, msg: "Please Enter Password");
              } else if (authcontroller.passwordController.text.length < 8) {
                context.showSnackBar(context,
                    msg: "Minimum 8 Characters Required ");
              } else if (authcontroller.passwordController.text !=
                  authcontroller.cPassController.text) {
                context.showSnackBar(context, msg: "Password not match");
              } else {
                authcontroller.userSignup(context: context);
              }
            },
            child: NextFloatingButton()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                Text("Whats your email address",
                    style: AppText.text22w500.copyWith(
                      color: Colors.black,
                    )),
                sizedBoxWithHeight(40),
                Text(
                  "Receipts will be sent to your email",
                  style: GoogleFonts.nunito(
                    color: Colors.grey.shade500,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                sizedBoxWithHeight(20),
                Container(
                  color: Colors.grey.shade300,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: authcontroller.emailController,
                    cursorColor: AppColors.grey500,
                    decoration: InputDecoration(
                      isDense: true,

                      // fillColor: Colors.grey.shade300,
                      // filled: true,

                      hintText: "Enter your email",
                      hintStyle: GoogleFonts.poppins(
                        color: AppColors.hintColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.grey.shade300,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: AppColors.grey500,
                    obscureText:
                        authcontroller.ispasswordvisible ? false : true,
                    controller: authcontroller.passwordController,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              authcontroller.changepasswordvisiblity();
                            },
                            child: Icon(
                              authcontroller.ispasswordvisible
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off_rounded,
                              color: Colors.black,
                            )),
                        isDense: true,
                        // fillColor: Colors.grey.shade300,
                        // filled: true,

                        hintText: "Password",
                        hintStyle: GoogleFonts.poppins(
                          color: AppColors.hintColor,
                          fontSize: 14.sp,
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
                Container(
                  color: Colors.grey.shade300,
                  child: TextFormField(
                    obscureText: authcontroller.isconfirmvisible ? false : true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: authcontroller.cPassController,
                    cursorColor: AppColors.grey500,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              authcontroller.changeconfirmpasswordvisiblity();
                            },
                            child: Icon(
                              authcontroller.isconfirmvisible
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off_rounded,
                              color: Colors.black,
                            )),
                        isDense: true,
                        // fillColor: Colors.grey.shade300,
                        // filled: true,

                        hintText: "Confirm Password",
                        hintStyle: GoogleFonts.poppins(
                          color: AppColors.hintColor,
                          fontSize: 14.sp,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
