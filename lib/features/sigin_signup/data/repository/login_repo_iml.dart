import 'package:clean_achitecture/error/failures.dart';
import 'package:clean_achitecture/features/sigin_signup/data/datasource/login_user.dart';
import 'package:clean_achitecture/features/sigin_signup/domain/entities/loginModel.dart';
import 'package:clean_achitecture/features/sigin_signup/domain/repositories/login_repo.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginUser loginUser;

  LoginRepositoryImpl(this.loginUser);

  @override
  Future<Either<Failure, bool>> login(LoginModel login) async {
    try {
      final user = await loginUser.login(login);
      return Right(user != null);
    } catch (exception) {
      return Left(ServerFailure());
    }
  }
}
