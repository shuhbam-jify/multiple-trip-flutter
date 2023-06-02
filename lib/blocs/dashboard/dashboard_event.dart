part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent extends Equatable {}

class FetchDashboardData extends DashboardEvent {
  final LatLng latLng;
  final String fulladdress;
  FetchDashboardData({
    required this.latLng,
    required this.fulladdress,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [latLng, fulladdress];
}

class InitBloc extends DashboardEvent {
  @override
  List<Object?> get props => [];
}
