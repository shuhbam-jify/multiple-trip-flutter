import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';
import 'package:multitrip_user/app_enverionment.dart';
import 'package:multitrip_user/blocs/account/account_controller.dart';
import 'package:multitrip_user/blocs/address/address_bloc.dart';
import 'package:multitrip_user/blocs/bookride/bookride_bloc.dart';
import 'package:multitrip_user/blocs/confirmride/confirmride_bloc.dart';
import 'package:multitrip_user/blocs/dashboard/dashboard_bloc.dart';
import 'package:multitrip_user/blocs/locationbloc/location_bloc_bloc.dart';
import 'package:multitrip_user/blocs/login/login_bloc.dart';
import 'package:multitrip_user/blocs/member/member_bloc.dart';
import 'package:multitrip_user/blocs/token/token_bloc.dart';
import 'package:multitrip_user/bottomnavigationbar.dart';
import 'package:multitrip_user/features/auth/login/login_mobile.dart';
import 'package:multitrip_user/features/splash/splash.dart';
import 'package:multitrip_user/logic/add_member/member_controller.dart';
import 'package:multitrip_user/logic/vehicle/vehicle_controller.dart';
import 'package:multitrip_user/routes.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiTrip extends StatefulWidget {
  const MultiTrip({
    super.key,
  });

  @override
  State<MultiTrip> createState() => _MultiTripState();
}

class _MultiTripState extends State<MultiTrip> {
  final getIt = GetIt.I;

  @override
  void initState() {
    super.initState();
    _registerNotifiers();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationBlocBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => TokenBloc(),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => AddressBloc(),
        ),
        BlocProvider(
          create: (context) => BookrideBloc(),
        ),
        BlocProvider(
          create: (context) => MemberBloc(),
        ),
        BlocProvider(
          create: (context) => ConfirmrideBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => getIt<AccountController>(),
          ),
          ChangeNotifierProvider(
            create: (_) => getIt<MembersController>(),
          ),
          // ChangeNotifierProvider(
          //   create: (_) => getIt<LocationProvider>(),
          // ),
          ChangeNotifierProvider(
            create: (_) => getIt<VehicleController>(),
          ),
        ],
        child: KeyboardVisibilityProvider(
          child: MaterialApp(
            color: AppColors.appColor,
            onGenerateRoute: Routes.onGenerateRoute,
            navigatorKey: AppEnvironment.rootNavigationKey,
            navigatorObservers: [
              AppEnvironment.routeObserver,
            ],
            initialRoute: Routes.splash,
            title: Strings.appname,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }

  void _registerNotifiers() {
    getIt.registerSingleton(
      VehicleController(),
    );
    getIt.registerSingleton(
      AccountController(),
    );
    getIt.registerSingleton(
      MembersController(),
    );
  }
}

Future isLoggedIn({required BuildContext context}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String istokenavailable = prefs.getString(Strings.userid) ?? "";
  if (istokenavailable == "") {
    AppEnvironment.navigator.pushNamed(AuthRoutes.loginmobile);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => LoginMobile(),
    //   ),
    // );
  } else {
    AppEnvironment.navigator.pushNamed(GeneralRoutes.pages);
  }
}
