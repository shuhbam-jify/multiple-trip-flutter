import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multitrip_user/api/app_repository.dart';
import 'package:multitrip_user/api/token_manager.dart';
import 'package:multitrip_user/app_enverionment.dart';
import 'package:multitrip_user/blocs/dashboard/dashboard_controller.dart';
import 'package:multitrip_user/features/account/account.dart';
import 'package:multitrip_user/features/ride_history/previous_ride.dart';
import 'package:multitrip_user/features/dashboard/home.dart';
import 'package:multitrip_user/models/route_arguments.dart';
import 'package:multitrip_user/my_flutter_app_icons.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;
  RouteArgument? routeArgument;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key? key,
    this.currentTab,
  }) {
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(
          currentTab.id,
        );
      }
    } else {
      currentTab = 0;
    }
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> with WidgetsBindingObserver {
  Widget currentPage = HomeScreen();
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      GetIt.instance
          .get<TokenManager>()
          .saveToken(GetIt.instance.get<TokenManager>().token ?? '');
      AppRepository().saveFcmToken(
        accesstoken: prefs.getString(Strings.accesstoken)!,
        userid: prefs.getString(Strings.userid)!,
        fcmToken: prefs.getString('fcm') ?? '',
      );
      _selectTab(widget.currentTab);
    });
  }

  @override
  void didChangeAppLifecycleState(state) {
    if (state == AppLifecycleState.resumed) {
      AppEnvironment.navigator.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => PagesWidget(
                    currentTab: 0,
                  )),
          (route) => false);
    }
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          currentPage = HomeScreen(
            parentScaffoldKey: widget.scaffoldKey,
          );
          _handleHome();

          break;
        case 1:
          currentPage = PreviousRides(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;
        case 2:
          currentPage = Account(
            parentScaffoldKey: widget.scaffoldKey,
          );
          break;
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        key: widget.scaffoldKey,
        body: IndexedStack(
          index: widget.currentTab,
          children: [
            HomeScreen(
              parentScaffoldKey: widget.scaffoldKey,
            ),
            PreviousRides(
              parentScaffoldKey: widget.scaffoldKey,
            ),
            Account(
              parentScaffoldKey: widget.scaffoldKey,
            )
          ],
        ),
        bottomNavigationBar: Container(
          color: AppColors.green,
          child: FancyBottomNavigation(
            barBackgroundColor: AppColors.green,
            circleColor: Colors.white,
            inactiveIconColor: Colors.black,
            activeIconColor: AppColors.green,
            initialSelection: widget.currentTab,
            onTabChangedListener: (int i) {
              _selectTab(
                i,
              );
            },
            tabs: [
              TabData(iconData: MyFlutterApp.home, title: Strings.home),
              TabData(
                iconData: MyFlutterApp.past,
                title: Strings.activity,
              ),
              TabData(iconData: MyFlutterApp.person, title: Strings.account),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleHome() async {
    var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .catchError((e) {
      print("error is $e");
    });
    List<Placemark> placemarks = await GeocodingPlatform.instance
        .placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks.first;

    final fullAddress =
        '${place.name}, ${place.subThoroughfare} ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}';
    if (!mounted) {
      return;
    }
    context.read<DashBoardController>().saveCurrentLocatoin(
        LatLng(position.latitude, position.longitude),
        fulladdress: fullAddress);
    context.read<DashBoardController>().callDashboardApi(
          LatLng(position.latitude, position.longitude),
        );
  }
}
