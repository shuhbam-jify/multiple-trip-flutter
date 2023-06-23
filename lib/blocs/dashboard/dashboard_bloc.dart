import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:multitrip_user/api/app_repository.dart';
import 'package:multitrip_user/models/dashboard.dart';
import 'package:multitrip_user/shared/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) async {
      print("Event is $event");

      if (event is FetchDashboardData) {
        emit.call(DashboardLoading());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        try {
          await AppRepository()
              .getdashboarddata(
            userid: prefs.getString(Strings.userid)!,
            latitude: event.latLng.latitude.toString(),
            longitude: event.latLng.longitude.toString(),
            accesstoken: prefs.getString(Strings.accesstoken)!,
          )
              .then((value) {
            if (value['code'] != null && value?["code"] == 200) {
              var _dashboard = Dashboard.fromJson(value);
              emit.call(
                DashboardLoaded(
                    fulladdeess: event.fulladdress,
                    dashboard: _dashboard,
                    currentlocation: event.latLng),
              );
            } else if (value["code"] == 201) {
              emit.call(DashbLoadFail(error: value["message"]));
            } else if (value["code"] == 401) {
              emit.call(
                  TokenExpired()); // Provider.of<AuthController>(context, listen: false).refreshaccesstoken(
              //     context: context,
              //     function: getdashboard(
              //         context: context, latitude: latitude, longitude: longitude));
            } else {
              emit.call(DashbLoadFail(error: value["message"]));
            }
          });
        } on Exception catch (e) {
          emit.call(
            DashbLoadFail(
              error: 'Unable to Proccess your request try after some time',
            ),
          );
        }
      } else if (event is InitBloc) {
        emit.call(DashboardInitial());
      }
    });
  }
}
