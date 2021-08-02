import 'package:clean_achitecture/error/failures.dart';
import 'package:clean_achitecture/features/sigin_signup/domain/entities/loginModel.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository { 
  Future<Either<Failure, bool>> login(LoginModel login);
}