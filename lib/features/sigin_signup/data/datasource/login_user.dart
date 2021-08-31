import 'package:clean_achitecture/features/sigin_signup/data/model/user.dart';
import 'package:clean_achitecture/features/sigin_signup/domain/entities/loginModel.dart';

class LoginUser {
  Future<User?> login(LoginModel login) async {
    if (login.login == "daovotan3@gmail.com" && login.password == "password") {
      return User(id: 1, user: "admin");
    } else {
      return null;
    }
  }
}
