import 'package:clean_achitecture/features/sigin_signup/model/user.dart';
import 'package:dio/dio.dart';

class SignUpAPI {
  final Dio _dio = Dio();
  bool? authenDB;
  Future<bool> createAccountAPI(User user) async {
    try {
      Response<dynamic> authenticateDB = await _dio.post(
        "https://findroomapi.herokuapp.com/findroom/adduser",
        data: user.toJson(),
      );
      print(authenticateDB);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return true;
  }
}
