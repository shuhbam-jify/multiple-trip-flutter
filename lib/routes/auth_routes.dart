part of 'routes.dart';

//auth routes

class AuthRoutes {
  /// leading string for routes in auth, this needs to be used when creating
  /// new route
  static const authLeading = '/auth-route';

  static const entermobile = '$authLeading/entermobile';
  static const otplogin = '$authLeading/otplogin';
  static const loginpassword = '$authLeading/loginpassword';
  static const signup = '$authLeading/signup';

  static final authRoutes = <String>{
    entermobile,
  };

  static Widget getPage(String currentRoute, Object? args) {
    Widget child;
    switch (currentRoute) {
      case AuthRoutes.entermobile:
        child = const LoginMobile();
        break;
      case AuthRoutes.otplogin:
        child = const OtpLogin();
        break;

      case AuthRoutes.loginpassword:
        child = const LoginPassword();
        break;
      case AuthRoutes.signup:
        child = const SignUp();
        break;
      default:
        child = const SizedBox();
    }
    return child;
  }
}
