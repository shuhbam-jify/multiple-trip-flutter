import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionProvider with ChangeNotifier {
  double? latitude;
  double? longitude;
  Future<void> fetchuserlocation() async {
    // Get the current location
    Permission.location.request().then((value) async {
      if (value.name == "granted") {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        // Access the latitude and longitude properties
        latitude = position.latitude;
        longitude = position.longitude;
        print(latitude);
        notifyListeners();
      }
    });
  }
}
