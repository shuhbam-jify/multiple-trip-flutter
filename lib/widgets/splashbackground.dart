import 'package:flutter/material.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/shared/ui/common/app_image.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImage(
          Images.background,
        ),
        Padding(
            padding: EdgeInsets.only(
              top: 170.h,
            ),
            child: Center(
              child: AppImage(
                Images.appLogo,
                height: 170.h,
                width: 170.h,
              ),
            ))
      ],
    );
  }
}
