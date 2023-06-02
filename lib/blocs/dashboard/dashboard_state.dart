part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState extends Equatable {}

class DashboardInitial extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {
  final bool isfetched;
  DashboardLoading({
    this.isfetched = false,
  });

  @override
  List<Object?> get props => [isfetched];
}

class DashboardLoaded extends DashboardState {
  final Dashboard dashboard;
  final bool isfetched;
  final String fulladdeess;
  final LatLng currentlocation;
  DashboardLoaded({
    this.isfetched = false,
    required this.dashboard,
    required this.currentlocation,
    required this.fulladdeess,
  });

  @override
  List<Object?> get props =>
      [dashboard, isfetched, fulladdeess, currentlocation];
}

class DashbLoadFail extends DashboardState {
  final String error;
  DashbLoadFail({required this.error});

  @override
  List<Object?> get props => [error];
}

class TokenExpired extends DashboardState {
  @override
  List<Object?> get props => [];
}
