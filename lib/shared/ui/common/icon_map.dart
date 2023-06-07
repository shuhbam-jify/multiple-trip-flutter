import 'package:flutter/material.dart';
import 'package:multitrip_user/shared/ui/common/app_image.dart';
import 'package:multitrip_user/shared/utils/utils.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

final pickUpIcon = AppImage(
  "assets/pickup.png",
  height: 200,
  width: 200,
).toBitmapDescriptor(
    logicalSize: const Size(200, 200), imageSize: const Size(200, 200));
final dropIcon = AppImage(
  "assets/drop.png",
  height: 200,
  width: 200,
).toBitmapDescriptor(
    logicalSize: const Size(200, 200), imageSize: const Size(200, 200));
