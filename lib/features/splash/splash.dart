import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:multitrip_user/blocs/token/token_bloc.dart';
import 'package:multitrip_user/multitrip.dart';
import 'package:multitrip_user/shared/ui/common/spacing.dart';
import 'package:multitrip_user/widgets/splashbackground.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/themes/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TokenBloc tokenBloc = TokenBloc();
  @override
  void initState() {
    tokenBloc = BlocProvider.of<TokenBloc>(context);

    checkrefreshtoken();
    super.initState();
  }

  Future<void> checkrefreshtoken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Strings.refreshtoken) == null) {
      tokenBloc.add(FetchRefreshToken(context: context));
    } else {
      tokenBloc.add(FetchAccessToken(context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()
      ..init(
        context,
      );

    return BlocListener<TokenBloc, TokenState>(
      listener: (context, state) {
        if (state is TokenLoading) {
          Loader.show(context,
              progressIndicator: CircularProgressIndicator(
                color: AppColors.appColor,
              ));
        } else if (state is AccessTokenLoaded) {
          Loader.hide();
          isLoggedIn(context: context);
        } else if (state is TokenFaied) {
          Loader.hide();
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.appColor,
          body: Column(
            children: [
              SplashBackground(),
              Padding(
                padding: EdgeInsets.all(
                  16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    sizedBoxWithHeight(40),
                    Text(
                      "Welcome To First Choice\nDesignated Drivers",
                      textAlign: TextAlign.center,
                      style: AppText.text28w500.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    sizedBoxWithHeight(80),
                    InkWell(
                      onTap: () {
                        isLoggedIn(
                          context: context,
                        );
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
                          color: AppColors.green,
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
          )),
    );
  }
}
