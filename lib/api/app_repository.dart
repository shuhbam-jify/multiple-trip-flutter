import 'package:multitrip_user/api/api_base_helper.dart';
import 'package:multitrip_user/models/accesstoken.dart';
import 'package:multitrip_user/models/address.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRepository {
  ApiBaseHelper helper = ApiBaseHelper();

// Refresh Token API
  Future<dynamic> getrefreshtoken() async {
    final response = await helper.post(
      "get_refresh_token",
      {
        "client_id": "ID:ZLEAC0HTM7V206H784M2",
        "client_secret": "KEY:U2IJZF01G64O4YQDGHCX",
      },
      {},
    );

    return response;
  }

// Access Token API
  Future<dynamic> getaccesstoken({
    required String refreshtoken,
  }) async {
    final response = await helper.post(
      "get_access_token",
      {"refresh_token": refreshtoken},
      {},
    );

    return response;
  }

// Check Moblie Number
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

// Verify OTP
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

// Create new User
  Future<dynamic> usersignup(
      {required String userid,
      required String email,
      required String password,
      required String accesstoken}) async {
    final response = await helper.post(
      "passenger_signup",
      {
        "user_id": userid,
        "email": email,
        "password": password,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

// Get Member List
  Future<dynamic> getmemberslist({
    required String userid,
    required String accesstoken,
  }) async {
    final response = await helper.post(
      "members_list",
      {
        "user_id": userid,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

// Add New Member
  Future<dynamic> addmember({
    required String userid,
    required String accesstoken,
    required String fname,
    required String lname,
    required String mobile_number,
    required String email,
    required String address,
  }) async {
    final response = await helper.post(
      "add_member",
      {
        "user_id": userid,
        "fname": fname,
        "lname": lname,
        "mobile_number": mobile_number,
        "email": email,
        "address": address
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

// Get User Dashboard
  Future<dynamic> getdashboarddata({
    required String accesstoken,
    required String userid,
    required String latitude,
    required String longitude,
  }) async {
    final response = await helper.post(
      "dashboard",
      {
        "user_id": userid,
        "latitude": latitude,
        "longitude": longitude,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

// Login By Password
  Future<dynamic> loginbypassword({
    required String mobilenumber,
    required String password,
    required String accesstoken,
  }) async {
    final response = await helper.post(
      "login_by_password",
      {
        "mobile_number": mobilenumber,
        "password": password,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  // Get Ride
  Future<dynamic> confirmuseride({
    required String accesstoken,
    required dynamic pickuplocation,
    required dynamic droplocation,
    required String userid,
  }) async {
    var body = {
      "user_id": userid,
      "pickup_location": pickuplocation,
      "drop_location": droplocation,
      "member_id": ""
    };
    print(body);
    final response = await helper.post(
      "confirm_ride",
      body,
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  //add vehicle
  Future<dynamic> addvehicle({
    required String userid,
    required String accesstoken,
    required String vehicle_name,
    required String vehicle_type,
    required String vehicle_color,
    required String vehicle_number,
  }) async {
    final response = await helper.post(
      "add_vehicle",
      {
        "user_id": userid,
        "vehicle_name": vehicle_name,
        "vehicle_type": vehicle_type,
        "vehicle_color": vehicle_color,
        "vehicle_number": vehicle_number,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

// Get Vehicle List
  Future<dynamic> getvehicle({
    required String userid,
    required String accesstoken,
  }) async {
    final response = await helper.post(
      "vehicle_list",
      {
        "user_id": userid,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  //delete vehicle
  Future<dynamic> deletevehicle({
    required String userid,
    required String accesstoken,
    required String vehicle_id,
  }) async {
    final response = await helper.post(
      "delete_vehicle",
      {"user_id": userid, "vehicle_id": vehicle_id},
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> douserlogout({
    required String accesstoken,
    required String userid,
  }) async {
    final response = await helper.post(
      "logout",
      {
        "user_id": userid,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> fetchaddress({
    required String accesstoken,
    required String userid,
  }) async {
    print("User id is $userid");
    final response = await helper.post(
      "address_list",
      {
        "user_id": userid,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> addAddress(
      {required String accesstoken,
      required String userid,
      required AddressElement element}) async {
    print("User id is $userid");
    final response = await helper.post(
      "add_address",
      {"user_id": userid, ...element.toJson()},
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> bookride(
      {required String accesstoken,
      required dynamic booking_number,
      required dynamic vehicle_id,
      required String notes,
      required String payment_mode,
      required String user_id}) async {
    var body = {
      "user_id": user_id,
      "booking_number": booking_number,
      "vehicle_id": vehicle_id,
      "notes": notes,
      "payment_mode": payment_mode
    };
    print(body);
    final response = await helper.post(
      "book_ride",
      body,
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<void> tokenExpired() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await getaccesstoken(
      refreshtoken: prefs.getString(Strings.refreshtoken)!,
    ).then((value) async {
      if (value == null || value['code'] == null) {}

      if (value["code"] == 200) {
        var accessToken = AccessToken.fromJson(value);

        await prefs.setString(Strings.accesstoken, accessToken.accessToken);
      }
    });
    //  context.showSnackBar(context, msg: value["message"]);
  }

  // Verify OTP
  Future<dynamic> getProfile({
    required String user_id,
    required String accesstoken,
  }) async {
    final response = await helper.post(
      "customer_profile",
      {
        "user_id": user_id,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> updateEmailProfile({
    required String user_id,
    required String accesstoken,
    required String email,
  }) async {
    final response = await helper.post(
      "update_customer_email",
      {"user_id": user_id, "email": email},
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> updateMobileProfile({
    required String user_id,
    required String accesstoken,
    required String mobile_number,
  }) async {
    final response = await helper.post(
      "update_customer_mobile",
      {"user_id": user_id, "mobile_number": mobile_number},
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> updateNameProfile({
    required String user_id,
    required String accesstoken,
    required String first_name,
    required String last_name,
  }) async {
    final response = await helper.post(
      "update_customer_name",
      {"user_id": user_id, "first_name": first_name, "last_name": last_name},
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> changePassword({
    required String user_id,
    required String accesstoken,
    required String password,
  }) async {
    final response = await helper.post(
      "change_password",
      {
        "user_id": user_id,
        "new_password": password,
      },
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }

  Future<dynamic> uploadImage({
    required String user_id,
    required String accesstoken,
    required String path,
  }) async {
    final response = await helper.uploadImage(
      "update_customer_image",
      {
        "user_id": user_id,
      },
      path,
      {
        "access_token": accesstoken,
      },
    );

    return response;
  }
}
