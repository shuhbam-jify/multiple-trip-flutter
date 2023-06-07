import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:multitrip_user/api/app_repository.dart';
import 'package:multitrip_user/models/login.dart';
import 'package:multitrip_user/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/verityotp.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is VerifyOTP) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        emit.call(OtpChecking());
        try {
          await AppRepository()
              .verifyOTP(
            otp: event.otp,
            accesstoken: prefs.getString(
              Strings.accesstoken,
            )!,
            mobilenumber: event.mobilenumber,
          )
              .then((value) async {
            if (value["code"] == 401) {
              emit.call(TokenExpired());
            } else if (value["code"] == 201) {
              emit.call(OtpFailed(
                error: value["message"].toString(),
              ));
            } else if (value["code"] == 200) {
              final _verifyotp = VerifyOtp.fromJson(value);
              if (_verifyotp.email == "") {
                emit.call(NewUser(verifyOTP: _verifyotp));
              } else {
                await prefs
                    .setString(
                  Strings.userid,
                  _verifyotp.userId,
                )
                    .whenComplete(() {
                  emit.call(AlreadyUser());
                });
              }
              //
            }
          });
        } on Exception catch (e) {
          emit.call(OtpFailed(
            error: e.toString(),
          ));
        }
      } else if (event is UserSignup) {
        emit.call(UserLoading());
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        try {
          await AppRepository()
              .usersignup(
            email: event.email,
            password: event.password,
            userid: event.userId,
            accesstoken: prefs.getString(
              Strings.accesstoken,
            )!,
          )
              .then((value) {
            if (value["code"] == 401) {
              emit.call(TokenExpired());
            } else if (value["code"] == 201) {
              emit.call(UserFailed(error: value["message"]));
            } else if (value["code"] == 200) {
              prefs.setString(
                Strings.userid,
                event.userId,
              );
              emit.call(UserSuccess(message: value["message"]));
            }
          });
        } on Exception catch (e) {
          emit.call(
            UserFailed(
              error: e.toString(),
            ),
          );
        }
      } else if (event is LoginByPassword) {
        emit.call(LoginLoading());
        try {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await AppRepository()
              .loginbypassword(
            password: event.password,
            accesstoken: prefs.getString(
              Strings.accesstoken,
            )!,
            mobilenumber: event.mobilenumber,
          )
              .then(
            (value) {
              if (value["code"] == 401) {
                emit.call(TokenExpired());
              } else if (value["code"] == 201) {
                emit.call(
                  LoginFail(
                    error: value["message"],
                  ),
                );
              } else if (value["code"] == 200) {
                var _verifyotp = VerifyOtp.fromJson(value);
                emit.call(
                  LoginPassowrdSuccess(
                    verifyOtp: _verifyotp,
                  ),
                );
              }
            },
          );
        } catch (e) {
          emit.call(
            LoginFail(
              error: e.toString(),
            ),
          );
        }
      }
      // } else if (event is DoUserLogout) {
      //   print(event);
      //   final SharedPreferences prefs = await SharedPreferences.getInstance();

      //   emit.call(LogoutLoading());
      //   try {
      //     await AppRepository()
      //         .douserlogout(
      //             accesstoken: prefs.getString(
      //               Strings.accesstoken,
      //             )!,
      //             userid: prefs.getString(Strings.userid)!)
      //         .then((value) {
      //       if (value["code"] == 401) {
      //         emit.call(TokenExpired());
      //       } else if (value["code"] == 201) {
      //         emit.call(
      //           LogoutFail(
      //             error: value["message"],
      //           ),
      //         );
      //       } else if (value["code"] == 200) {
      //         emit.call(
      //           LogoutSuccess(
      //             message: value["message"],
      //           ),
      //         );
      //         prefs.clear();
      //       }
      //     });
      //   } catch (e) {
      //     emit.call(
      //       LogoutFail(
      //         error: e.toString(),
      //       ),
      //     );
      //   }
      // }
    });
  }
}
