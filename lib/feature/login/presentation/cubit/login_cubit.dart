import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_oriented/core/error/failures.dart';
import 'package:feature_oriented/core/utils/constants.dart';
import 'package:feature_oriented/feature/login/domain/entities/login.dart';
import 'package:feature_oriented/feature/login/domain/usecases/login_user.dart';
import 'package:flutter/foundation.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUser}) : super(NotLoggedState());

  final LoginUser loginUser;

  void signInUser({required email, required password}) async {
    emit(LoadingState());
    final result =
        await loginUser(LoginParams(email: email, password: password));
    result.fold((failure) {
      if (failure is NoConnectionFailure) {
        emit(const ErrorState(message: NO_CONNECTION_ERROR));
      } else {
        emit(const ErrorState(message: LOGGING_ERROR));
      }
    }, (success) {
      print('==============================');
      print( success.data?.toJson().toString());
      print('==============================');
      emit(LoggedState(login: Login(data: success.data)));
    });
  }
}
