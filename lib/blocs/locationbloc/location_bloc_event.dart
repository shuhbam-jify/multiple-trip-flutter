part of 'location_bloc_bloc.dart';

@immutable
abstract class LocationBlocEvent {}

class FetchSuggestions extends LocationBlocEvent {
  final String query;
  FetchSuggestions({required this.query});
}

class InitBloc extends LocationBlocEvent {}

class FetchPickupLatlong extends LocationBlocEvent {}

class FetchDropLatlong extends LocationBlocEvent {
  final String placeId;
  FetchDropLatlong({required this.placeId});
}

class FetchPickupLatLong extends LocationBlocEvent {
  final String placeId;
  FetchPickupLatLong({
    required this.placeId,
  });
}

class ClearSuggestionList extends LocationBlocEvent {}
