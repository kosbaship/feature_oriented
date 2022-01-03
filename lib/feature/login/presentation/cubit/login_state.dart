part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}


class NotLoggedState extends LoginState {}

class LoadingState extends LoginState {}

class LoggedState extends LoginState {
  final Login login;

  const LoggedState({required this.login});

  @override
  List<Object> get props => [login];
}

class ErrorState extends LoginState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
