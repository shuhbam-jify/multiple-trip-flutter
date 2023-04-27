import 'package:flutter/material.dart';
import 'package:multitrip_user/bottomnavigationbar.dart';
import 'package:multitrip_user/features/account/account.dart';
import 'package:multitrip_user/features/account/account_change_password.dart';
import 'package:multitrip_user/features/account/account_email.dart';
import 'package:multitrip_user/features/account/account_info.dart';
import 'package:multitrip_user/features/account/account_name.dart';
import 'package:multitrip_user/features/account/account_phone.dart';
import 'package:multitrip_user/features/add_member/add_member.dart';
import 'package:multitrip_user/features/auth/login/login_mobile.dart';
import 'package:multitrip_user/features/auth/login/login_password.dart';
import 'package:multitrip_user/features/auth/login/otp_login.dart';
import 'package:multitrip_user/features/auth/signup/signup.dart';
import 'package:multitrip_user/features/book_ride/booking_otp.dart';
import 'package:multitrip_user/features/book_ride/home.dart';
import 'package:multitrip_user/features/book_ride/pickupdropaddress.dart';
import 'package:multitrip_user/features/book_ride/ride_pick_up.dart';
import 'package:multitrip_user/features/book_ride/schedule_ride.dart';
import 'package:multitrip_user/features/book_ride/select_rider.dart';
import 'package:multitrip_user/features/splash/splash.dart';

part 'auth_routes.dart';
part 'general_routes.dart';

///
/// Routes are divided into multiple parts based on modules
/// [AuthRoutes] contains auth module routes
///

class Routes {
  static String currentRoute = '/';
  static const splash = '/';

  static final routes = <String>{
    splash,
    ...AuthRoutes.authRoutes,
    ...GeneralRoutes.generalRoutes,
    //  ...CreatePostRoutes.createPostRoutes,
    // ...PostRoutes.postRoutes,
    //  ...ProfileRoutes.profileRoutes,
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    currentRoute = settings.name ?? '/';
    Widget child;

    if (currentRoute.startsWith(AuthRoutes.authLeading)) {
      child = AuthRoutes.getPage(currentRoute, args);
    } else if (currentRoute.startsWith(GeneralRoutes.generalLeading)) {
      child = GeneralRoutes.getPage(currentRoute, args);
    } else if (currentRoute == Routes.splash) {
      child = const SplashScreen();
    } else {
      child = const SizedBox();
    }

    return MaterialPageRoute(
      builder: (_) => child,
      settings: settings,
    );
  }
}
