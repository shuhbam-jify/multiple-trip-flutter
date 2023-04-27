import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:multitrip_user/api/app_repository.dart';
import 'package:multitrip_user/models/accesstoken.dart';
import 'package:multitrip_user/models/login.dart';
import 'package:multitrip_user/models/refresh_token.dart';
import 'package:multitrip_user/models/verityotp.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  late RefreshToken _refreshToken;
  get refreshtoken => _refreshToken;
  late AccessToken _accessToken;
  get accesstoken => _accessToken;
  late VerifyOtp _verifyotp;
  VerifyOtp get verifyotp => _verifyotp;

  bool ispasswordvisible = false;
  bool isconfirmvisible = false;

  int deviceType = 1;

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPassController = TextEditingController();

  late Login _login;
  Login get login => _login;

  void changeconfirmpasswordvisiblity() {
    isconfirmvisible = !isconfirmvisible;
    notifyListeners();
  }

  void changepasswordvisiblity() {
    ispasswordvisible = !ispasswordvisible;
    notifyListeners();
  }

  void getrefreshtoken({
    required BuildContext context,
  }) {
    AppRepository().getrefreshtoken().then((value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value["code"] == 200) {
        _refreshToken = RefreshToken.fromJson(value);

        prefs
            .setString(Strings.refreshtoken, _refreshToken.refreshToken)
            .whenComplete(() {
          this.getaccesstoken(context: context);
        });
        //   Loader.hide();
        notifyListeners();
      } else {
        context.showSnackBar(context, msg: value["message"]);
        notifyListeners();
      }
    });
  }

  Future<void> getaccesstoken({required BuildContext context}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AppRepository()
        .getaccesstoken(
      refreshtoken: prefs.getString(Strings.refreshtoken)!,
    )
        .then((value) {
      if (value["code"] == 200) {
        _accessToken = AccessToken.fromJson(value);
        prefs.setString(Strings.accesstoken, _accessToken.accessToken);
        notifyListeners();
      } else {
        context.showSnackBar(context, msg: value["message"]);
        notifyListeners();
      }
    });
  }

  Future<void> douserlogin({required BuildContext context}) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (Platform.isAndroid) {
      deviceType = 1;
    } else {
      deviceType = 2;
    }

    AppRepository()
        .douserlogin(
      accesstoken: prefs.getString(
        Strings.accesstoken,
      )!,
      devicetype: deviceType.toString(),
      mobilenumber: phoneController.text,
      fcm: fcmToken!,
    )
        .then((value) {
      if (value["code"] == 201) {
        context.showSnackBar(context, msg: value["message"]);
        Loader.hide();
      } else if (value["code"] == 200) {
        _login = Login.fromJson(value);
        // context.showSnackBar(context, msg: login.message);
        AppEnvironment.navigator.pushNamed(AuthRoutes.otplogin);
        Loader.hide();
      }
    });
    notifyListeners();
  }

  Future<void> verifyOTP({required BuildContext context}) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AppRepository()
        .verifyOTP(
      otp: otpController.text,
      accesstoken: prefs.getString(
        Strings.accesstoken,
      )!,
      mobilenumber: phoneController.text,
    )
        .then((value) {
      if (value["code"] == 201) {
        context.showSnackBar(context, msg: value["message"]);
        Loader.hide();
      } else if (value["code"] == 200) {
        _verifyotp = VerifyOtp.fromJson(value);
        context.showSnackBar(context, msg: verifyotp.message);
        if (verifyotp.email == "") {
          AppEnvironment.navigator.pushNamed(AuthRoutes.signup);
        } else {
          prefs
              .setString(
            Strings.userid,
            verifyotp.userId,
          )
              .whenComplete(() {
            AppEnvironment.navigator.pushNamed(
              GeneralRoutes.bottombar,
            );
          });
        }
        //
        Loader.hide();
      }
    });
    notifyListeners();
  }

  Future<void> userSignup({required BuildContext context}) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AppRepository()
        .usersignup(
      email: emailController.text,
      password: passwordController.text,
      userid: verifyotp.userId,
      accesstoken: prefs.getString(
        Strings.accesstoken,
      )!,
    )
        .then((value) {
      if (value["code"] == 201) {
        context.showSnackBar(context, msg: value["message"]);
        Loader.hide();
      } else if (value["code"] == 200) {
        context.showSnackBar(context, msg: value["message"]);
        prefs.setString(
          Strings.userid,
          verifyotp.userId,
        );
        AppEnvironment.navigator.pushNamed(GeneralRoutes.bottombar);
        Loader.hide();
      }
    });
    notifyListeners();
  }
}
