import 'package:multitrip_user/api/api_base_helper.dart';

class AppRepository {
  ApiBaseHelper helper = ApiBaseHelper();

  Future<dynamic> getrefreshtoken() async {
    final response = await helper.post("get_refresh_token", {
      "client_id": "ID:ZLEAC0HTM7V206H784M2",
      "client_secret": "KEY:U2IJZF01G64O4YQDGHCX",
    }, {});

    return response;
  }

  Future<dynamic> getaccesstoken({required String refreshtoken}) async {
    final response = await helper.post(
      "get_access_token",
      {"refresh_token": refreshtoken},
      {},
    );

    return response;
  }

  Future<dynamic> douserlogin({
    required String accesstoken,
    required String devicetype,
    required String mobilenumber,
    required String fcm,
  }) async {
    final response = await helper.post(
      "login",
      {
        "mobile_number": mobilenumber,
        "device_type": devicetype,
        "fcm_id": fcm,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> verifyOTP(
      {required String mobilenumber,
      required String otp,
      required String accesstoken}) async {
    final response = await helper.post(
      "verify_otp",
      {
        "mobile_number": mobilenumber,
        "otp": otp,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> usersignup(
      {required String userid,
      required String email,
      required String password,
      required String accesstoken}) async {
    final response = await helper.post(
      "passenger_signup",
      {"user_id": userid, "email": email, "password": password},
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }
}
