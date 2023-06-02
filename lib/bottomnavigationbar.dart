import 'package:flutter/material.dart';
import 'package:multitrip_user/features/account/account.dart';
import 'package:multitrip_user/features/ride_history/previous_ride.dart';
import 'package:multitrip_user/features/dashboard/home.dart';
import 'package:multitrip_user/models/route_arguments.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:multitrip_user/themes/app_text.dart';

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
          color: AppColors.appColor,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // Fixed
            selectedItemColor: AppColors.green,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 22,

            elevation: 0,
            selectedLabelStyle: AppText.text14w400.copyWith(
              color: AppColors.green,
              fontSize: 14.sp,
            ),
            unselectedLabelStyle: AppText.text14w400.copyWith(
              color: AppColors.grey500,
              fontSize: 14.sp,
            ),
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(
              size: 22,
              color: AppColors.green,
            ),
            unselectedItemColor: AppColors.grey500,
            currentIndex: widget.currentTab,
            onTap: (int i) {
              this._selectTab(
                i,
              );
            },
            items: [
              BottomNavigationBarItem(
                icon: new Icon(
                  Icons.home,
                ),
                label: Strings.home,
              ),
              BottomNavigationBarItem(
                icon: new Icon(
                  Icons.ac_unit,
                ),
                label: Strings.activity,
              ),
              BottomNavigationBarItem(
                label: Strings.account,
                icon: new Icon(
                  Icons.person,
                ),
              ),
            ],
          ),
        ));
  }
}
