import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multitrip_user/blocs/dashboard/dashboard_bloc.dart';
import 'package:multitrip_user/features/account/account.dart';
import 'package:multitrip_user/features/ride_history/previous_ride.dart';
import 'package:multitrip_user/features/dashboard/home.dart';
import 'package:multitrip_user/models/route_arguments.dart';
import 'package:multitrip_user/my_flutter_app_icons.dart';
import 'package:multitrip_user/shared/shared.dart';

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

class _PagesWidgetState extends State<PagesWidget> {
  Widget currentPage = HomeScreen();
  @override
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
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
    super.dispose();
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: widget.scaffoldKey,
//         body: IndexedStack(
//           index: widget.currentTab,
//           children: [

//           ],
//         ),
//         bottomNavigationBar: Container(
//           color: AppColors.appColor,
//           child: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed, // Fixed
//             selectedItemColor: AppColors.green,
//             selectedFontSize: 0,
//             unselectedFontSize: 0,
//             iconSize: 22,

//             elevation: 0,
//             selectedLabelStyle: AppText.text14w400.copyWith(
//               color: AppColors.green,
//               fontSize: 14.sp,
//             ),
//             unselectedLabelStyle: AppText.text14w400.copyWith(
//               color: AppColors.grey500,
//               fontSize: 14.sp,
//             ),
//             backgroundColor: Colors.transparent,
//             selectedIconTheme: IconThemeData(
//               size: 22,
//               color: AppColors.green,
//             ),
//             unselectedItemColor: AppColors.grey500,
//             currentIndex: widget.currentTab,
//             onTap: (int i) {
//               this._selectTab(
//                 i,
//               );
//             },
//             items: [
//               BottomNavigationBarItem(
//                 icon: new Icon(
//                   Icons.home,
//                 ),
//                 label: Strings.home,
//               ),
//               BottomNavigationBarItem(
//                 icon: new Icon(
//                   Icons.ac_unit,
//                 ),
//                 label: Strings.activity,
//               ),
//               BottomNavigationBarItem(
//                 label: Strings.account,
//                 icon: new Icon(
//                   Icons.person,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Future<void> _handleHome() async {
    var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .catchError((e) {
      print("error is $e");
    });
    List<Placemark> placemarks = await GeocodingPlatform.instance
        .placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks.first;

    final fullAddress =
        '${place.name}, ${place.subThoroughfare} ${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}';

    context.read<DashboardBloc>().add(
          FetchDashboardData(
              latLng: LatLng(position.latitude, position.longitude),
              fulladdress: fullAddress),
        );
  }
}
