import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_achitecture/features/sigin_signup/domain/entities/loginModel.dart';
import 'package:clean_achitecture/features/sigin_signup/domain/usecases/login.dart';
import 'package:clean_achitecture/features/sigin_signup/presentation/dto/login_dto.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
    this.loginUseCase,
  ) : super(LoginInitial());
  final LoginUseCase loginUseCase;
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is CheckLoginEvent) {
      yield CheckingLoginState();
      final result = await loginUseCase.call(
        Params(
          login: LoginModel(
              password: event.login.password, login: event.login.username),
        ),
      );
      yield result.fold((l) => ErrorLoggedState(),
          (r) => (r) ? LoggedState() : ErrorLoggedState());
    }
  }
}
