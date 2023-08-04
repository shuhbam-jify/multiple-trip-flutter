import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:multitrip_user/api/app_repository.dart';

import 'package:multitrip_user/models/listmembers.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembersController extends ChangeNotifier {
  ListMembers? _listMembers;
  ListMembers? get listmembers => _listMembers;
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isloading = false;

  clear() {
    firstnamecontroller.clear();
    lastnameController.clear();
    emailController.clear();
    addressController.clear();
    phoneController.clear();
  }

  Future<void> getmembers({
    required BuildContext context,
  }) async {
    isloading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AppRepository()
        .getmemberslist(
      accesstoken: prefs.getString(
        Strings.accesstoken,
      )!,
      userid: prefs.getString(
        Strings.userid,
      )!,
    )
        .then((value) {
      if (value["code"] == 200) {
        _listMembers = ListMembers.fromJson(
          value,
        );
        isloading = false;
        Loader.hide();
        notifyListeners();
      } else if (value["code"] == 401) {
        AppRepository().saveAccessToken();
        // Provider.of<AuthController>(context, listen: false).refreshaccesstoken(
      } else if (value["code"] == 201) {
        Loader.hide();
        //     context.showSnackBar(context, msg: value["message"]);
      } else {
        // context.showSnackBar(context, msg: value["message"]);
        isloading = false;
        _listMembers = ListMembers(
          code: 200,
          message: "",
          members: [
            Member(
              id: "0",
              fname: "Me",
              lname: "",
              mobileNumber: "",
              email: "",
              address: "",
            )
          ],
        );
        Loader.hide();
        notifyListeners();
      }
    });
  }

  Future<void> addmember({required BuildContext context}) async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    // isloading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AppRepository()
        .addmember(
            address: addressController.text,
            email: emailController.text,
            fname: firstnamecontroller.text,
            lname: lastnameController.text,
            mobile_number: phoneController.text,
            accesstoken: prefs.getString(Strings.accesstoken)!,
            userid: prefs.getString(Strings.userid)!)
        .then((value) {
      if (value["code"] == 200) {
        clear();
        context.showSnackBar(context, msg: value["message"]);
        Navigator.pop(context);

        this.getmembers(context: context).then((value) {
          Navigator.pop(context);
        });
        //   isloading = false;
        Loader.hide();
        notifyListeners();
      } else if (value["code"] == 201) {
        Loader.hide();
        context.showSnackBar(context, msg: value["message"]);
      } else if (value["code"] == 401) {
        // Provider.of<AuthController>(context, listen: false).refreshaccesstoken(
        //     context: context, function: addmember(context: context));
      } else {
        context.showSnackBar(context, msg: value["message"]);
        //  isloading = false;
        Loader.hide();
        notifyListeners();
      }
    });
  }
}
