import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:multitrip_user/features/auth/login/logic/auth_controller.dart';
import 'package:multitrip_user/features/logic/app_permission_handler.dart';
import 'package:multitrip_user/routes/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/themes/themes.dart';
import 'package:provider/provider.dart';

class MultiTrip extends StatefulWidget {
  const MultiTrip({super.key});

  @override
  State<MultiTrip> createState() => _MultiTripState();
}

class _MultiTripState extends State<MultiTrip> {
  final getIt = GetIt.I;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AuthController>()),
        ChangeNotifierProvider(create: (_) => getIt<AppPermissionProvider>()),
      ],
      child: ValueListenableBuilder(
        valueListenable: AppEnvironment.appTheme,
        builder: (_, __, ___) {
          return MaterialApp(
            theme: themeData,
            color: AppColors.appColor,
            title: "First Choice",
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.onGenerateRoute,
            navigatorKey: AppEnvironment.rootNavigationKey,
            navigatorObservers: [
              AppEnvironment.routeObserver,
            ],
            localizationsDelegates: const [FormBuilderLocalizations.delegate],
            initialRoute: Routes.splash,
          );
        },
      ),
    );
  }

  void _preCacheImages() {
    // CommonUtils.preCacheNetworkImages(context, [Images.foxLogo]);
  }

  void _initialize() {
    _registerRepos();
    _registerNotifiers();
    _preCacheImages();
  }

  void _registerRepos() {}

  void _registerNotifiers() {
    getIt.registerSingleton(AuthController());
    getIt.registerSingleton(AppPermissionProvider());
  }
}

//}