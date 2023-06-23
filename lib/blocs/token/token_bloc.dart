import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:multitrip_user/api/app_repository.dart';
import 'package:multitrip_user/models/refresh_token.dart';
import 'package:multitrip_user/multitrip.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/accesstoken.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  TokenBloc() : super(TokenInitial()) {
    on<TokenEvent>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (event is FetchRefreshToken) {
        emit.call(TokenLoading());

        try {
          await AppRepository().getrefreshtoken().then((value) async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            if (value["code"] == 200) {
              var refreshtoken = RefreshToken.fromJson(value);
              emit.call(
                RefreshTokenLoaded(
                  refreshToken: refreshtoken,
                ),
              );
              // _refreshToken = RefreshToken.fromJson(value);

              prefs
                  .setString(Strings.refreshtoken, refreshtoken.refreshToken)
                  .whenComplete(() {
                this.add(FetchAccessToken(context: event.context));
              });
              //   Loader.hide();
            }
          }).onError((error, stackTrace) {
            emit.call(TokenFaied(error: error.toString()));
          });
        } on Exception catch (e) {
          emit.call(TokenFaied(error: e.toString()));
        }
      } else if (event is FetchAccessToken) {
        print("event is $event");
        emit.call(TokenLoading());

        try {
          final refreshToken = prefs.getString(Strings.refreshtoken);
          if (refreshToken != null) {
            await AppRepository()
                .getaccesstoken(
              refreshtoken: prefs.getString(Strings.refreshtoken)!,
            )
                .then((value) {
              if (value == null || value['code'] == null) {
                this.add(FetchAccessToken(context: event.context));
                return;
              }

              if (value["code"] == 200) {
                var accessToken = AccessToken.fromJson(value);
                emit.call(AccessTokenLoaded(accessToken: accessToken));
                prefs.setString(Strings.accesstoken, accessToken.accessToken);
              } else if (value["code"] == 201) {
                emit.call(
                  TokenFaied(error: value["message"]),
                );
                //  context.showSnackBar(context, msg: value["message"]);
              } else if (value["code"] == 401) {
                this.add(FetchRefreshToken(context: event.context));
              }
            });
          }
        } on Exception catch (e) {
          emit.call(TokenFaied(error: e.toString()));
        }
      }
    });
  }
}
