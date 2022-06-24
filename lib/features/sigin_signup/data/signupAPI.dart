import 'package:dio/dio.dart';

class SignUpAPI {
  final Dio _dio = Dio();
  bool? authenDB;
  Future<bool> createAccountAPI(String username, String password) async {
    try {
      Response<dynamic> authenticateDB =
          await _dio.post("https://findroomapi.herokuapp.com/findroom/adduser",
              data: {
                "name": username,
                "password": password,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
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
