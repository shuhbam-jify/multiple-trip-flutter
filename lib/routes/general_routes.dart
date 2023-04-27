part of 'routes.dart';

class GeneralRoutes {
  /// leading string for general routes, this needs to be used when creating
  /// new route
  static const generalLeading = '/general-route';

  static const addmember = '$generalLeading/addmember';
  static const scheduleride = '$generalLeading/scheduleride';
  static const homescreen = '$generalLeading/homescreen';
  static const bottombar = '$generalLeading/bottombar';
  static const pickupdropaddress = '$generalLeading/pickupdropaddress';

  static const selectRider = '$generalLeading/selectRider';
  static const ridepickup = '$generalLeading/ridepickup';
  static const bookingotp = '$generalLeading/bookingotp';
  static const account = '$generalLeading/account';

  static const accountinfo = '$generalLeading/accountinfo';
  static const accounname = '$generalLeading/accountname';
  static const accounphone = '$generalLeading/accountphone';
  static const accounemail = '$generalLeading/accountemail';
  static const accounchangepassword = '$generalLeading/changepassword';

  static final generalRoutes = <String>{};

  static Widget getPage(String currentRoute, Object? args) {
    Widget child;
    switch (currentRoute) {
      case GeneralRoutes.addmember:
        child = const AddMember();
        break;
      case GeneralRoutes.scheduleride:
        child = const ScheduleRide();
        break;
      case GeneralRoutes.homescreen:
        child = const HomeScreen();
        break;
      case GeneralRoutes.bottombar:
        child = PagesWidget(
          currentTab: args,
        );
        break;
      case GeneralRoutes.pickupdropaddress:
        child = PickupDropAddress();
        break;
      case GeneralRoutes.selectRider:
        child = SelectRider();
        break;
      case GeneralRoutes.ridepickup:
        child = RidePickup();
        break;
      case GeneralRoutes.bookingotp:
        child = BookingOTP();
        break;
      case GeneralRoutes.account:
        child = Account();
        break;
      case GeneralRoutes.accountinfo:
        child = AccountInfo();
        break;
      case GeneralRoutes.accounname:
        child = AccountName();
        break;
      case GeneralRoutes.accounphone:
        child = AccountPhone();
        break;
      case GeneralRoutes.accounemail:
        child = AccountEmail();
        break;
      case GeneralRoutes.accounchangepassword:
        child = AccountChangePassword();
        break;
      default:
        child = const SizedBox();
    }
    return child;
  }
}
