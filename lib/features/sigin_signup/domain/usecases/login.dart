import 'package:clean_achitecture/error/failures.dart';
import 'package:clean_achitecture/features/sigin_signup/domain/entities/loginModel.dart';
import 'package:clean_achitecture/features/sigin_signup/domain/repositories/login_repo.dart';
import 'package:clean_achitecture/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase implements UseCase<bool, Params> {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
      return await loginRepository.login(params.login);
  }
}

class Params extends Equatable {
  final LoginModel login;

  Params(this.login);

 

  @override
  List<Object> get props => [login];
}
