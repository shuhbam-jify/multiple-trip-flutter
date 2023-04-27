import 'package:flutter/material.dart';
import 'package:multitrip_user/features/auth/login/logic/auth_controller.dart';
import 'package:multitrip_user/features/common/splashbackground.dart';
import 'package:multitrip_user/features/logic/app_permission_handler.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/themes/app_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Provider.of<AuthController>(context, listen: false)
        .getrefreshtoken(context: context);
    Future.delayed(Duration(seconds: 3), () {
      isLoggedIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);

    return FutureBuilder(
        future: Provider.of<AppPermissionProvider>(context, listen: false)
            .fetchuserlocation(),
        builder: (context, s) {
          return Scaffold(
              backgroundColor: AppColors.appColor,
              body: Column(
                children: [
                  SplashBackground(),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          "Welcome To First Choice\nDesignated Drivers",
                          textAlign: TextAlign.center,
                          style: AppText.text28w500.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 80.h,
                        ),
                        InkWell(
                          onTap: () {
                            isLoggedIn();
                          },
                          child: Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Get Started",
                                style: AppText.text15w400.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(
                                10.r,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}

Future isLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String istokenavailable = prefs.getString(Strings.userid) ?? "";
  if (istokenavailable == "") {
    AppEnvironment.navigator.pushReplacementNamed(AuthRoutes.entermobile);
  } else {
    AppEnvironment.navigator.pushReplacementNamed(
      GeneralRoutes.bottombar,
    );
  }
}
