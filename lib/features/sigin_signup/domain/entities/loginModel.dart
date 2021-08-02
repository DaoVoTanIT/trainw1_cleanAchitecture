import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String login;
  final String password;

  LoginModel(this.login, this.password);


  @override
  List<Object> get props => [login, password];
}
