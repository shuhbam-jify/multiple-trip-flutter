import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:multitrip_user/multitrip.dart';
import 'package:multitrip_user/shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  InternetConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        // if (ModalRoute.of(AppEnvironment.ctx)?.settings.name ==
        //     GeneralRoutes.noInternet) {
        //   AppEnvironment.navigator.pop();
        // }
        Logger.logMsg('MAIN', 'Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        // AppEnvironment.navigator.pushNamed(GeneralRoutes.noInternet);
        break;
    }
  });

  runApp(const MultiTrip());
}
