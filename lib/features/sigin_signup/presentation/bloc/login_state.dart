part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckingLoginState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoggedState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorLoggedState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
