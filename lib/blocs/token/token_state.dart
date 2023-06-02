part of 'token_bloc.dart';

@immutable
abstract class TokenState {}

class TokenInitial extends TokenState {}

class TokenLoading extends TokenState {}

class TokenFaied extends TokenState {
  final String error;
  TokenFaied({required this.error});
}

class RefreshTokenLoaded extends TokenState {
  final RefreshToken refreshToken;
  RefreshTokenLoaded({required this.refreshToken});
}

class AccessTokenLoaded extends TokenState {
  final AccessToken accessToken;
  AccessTokenLoaded({required this.accessToken});
}
