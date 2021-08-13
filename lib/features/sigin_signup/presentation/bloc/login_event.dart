part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

}
class CheckLoginEvent extends LoginEvent {
  final LoginDTO login;

  CheckLoginEvent({required this.login});

  @override
  List<Object> get props => [login];
}
