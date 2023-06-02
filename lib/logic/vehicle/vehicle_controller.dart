import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:multitrip_user/api/app_repository.dart';
import 'package:multitrip_user/models/vehicles.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleController extends ChangeNotifier {
  Vehicles? _vehicles;
  Vehicles? get vehicles => _vehicles;
  bool isloading = false;

  TextEditingController vehiclename = TextEditingController();
  TextEditingController vehiclenumber = TextEditingController();
  TextEditingController vehiclecolor = TextEditingController();
  TextEditingController vehicletype = TextEditingController();

  Future<void> addvehicle({required BuildContext context}) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    // isloading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AppRepository()
        .addvehicle(
            vehicle_color: vehiclecolor.text,
            vehicle_name: vehiclename.text,
            vehicle_number: vehiclenumber.text,
            vehicle_type: vehicletype.text,
            accesstoken: prefs.getString(Strings.accesstoken)!,
            userid: prefs.getString(Strings.userid)!)
        .then((value) {
      if (value["code"] == 200) {
        context.showSnackBar(context, msg: value["message"]);
        Navigator.pop(context);
        vehiclecolor.text = "";
        vehiclename.text = "";
        vehiclenumber.text = "";
        vehicletype.text = "";
        getvehicles(context: context);
        //   isloading = false;
        Loader.hide();
        notifyListeners();
      } else if (value["code"] == 401) {
        // Provider.of<AuthController>(context, listen: false).refreshaccesstoken(
        //     context: context, function: addvehicle(context: context));
      } else if (value["code"] == 201) {
        Loader.hide();
        context.showSnackBar(context, msg: value["message"]);
      } else {
        context.showSnackBar(context, msg: value["message"]);
        //  isloading = false;
        Loader.hide();
        notifyListeners();
      }
    });
  }

  Future<void> getvehicles({required BuildContext context}) async {
    isloading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AppRepository()
        .getvehicle(
      accesstoken: prefs.getString(
        Strings.accesstoken,
      )!,
      userid: prefs.getString(
        Strings.userid,
      )!,
    )
        .then((value) {
      if (value["code"] == 200) {
        _vehicles = Vehicles.fromJson(
          value,
        );
        isloading = false;
        Loader.hide();
        notifyListeners();
      } else if (value["code"] == 401) {
        // Provider.of<AuthController>(
        //   context,
        //   listen: false,
        // ).refreshaccesstoken(
        //   context: context,
        //   function: getvehicles(
        //     context: context,
        //   ),
        // );
      } else if (value["code"] == 201) {
        Loader.hide();
        context.showSnackBar(context, msg: value["message"]);
      } else {
        // // context.showSnackBar(context, msg: value["message"]);
        // isloading = false;
        // _listMembers = ListMembers(
        //   code: 200,
        //   message: "",
        //   members: [
        //     Member(
        //       id: "0",
        //       fname: "Me",
        //       lname: "",
        //       mobileNumber: "",
        //       email: "",
        //       address: "",
        //     )
        //   ],
        // );
        Loader.hide();
        notifyListeners();
      }
    });
  }

  Future<void> deletevehicle(
      {required BuildContext context, required String vehicle_id}) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    // isloading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AppRepository()
        .deletevehicle(
      vehicle_id: vehicle_id,
      accesstoken: prefs.getString(
        Strings.accesstoken,
      )!,
      userid: prefs.getString(
        Strings.userid,
      )!,
    )
        .then((value) {
      if (value["code"] == 200) {
        getvehicles(context: context);
        //   isloading = false;
        Loader.hide();
        notifyListeners();
      } else if (value["code"] == 401) {
        // Provider.of<AuthController>(
        //   context,
        //   listen: false,
        // ).refreshaccesstoken(
        //   context: context,
        //   function: deletevehicle(
        //     context: context,
        //     vehicle_id: vehicle_id,
        //   ),
        // );
      } else if (value["code"] == 201) {
        Loader.hide();
        context.showSnackBar(context, msg: value["message"]);
      } else {
        context.showSnackBar(context, msg: value["message"]);
        //  isloading = false;
        Loader.hide();
        notifyListeners();
      }
    });
  }
}
