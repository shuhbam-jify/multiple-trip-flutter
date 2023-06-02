part of 'token_bloc.dart';

@immutable
abstract class TokenEvent {}

class FetchRefreshToken extends TokenEvent {
  final BuildContext context;

  FetchRefreshToken({required this.context});
}

class FetchAccessToken extends TokenEvent {
  final BuildContext context;
  FetchAccessToken({required this.context});
}
