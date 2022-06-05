import 'package:dio/dio.dart';

class LoginAPI {
  final Dio _dio = Dio();
  String? authenDB;
  Future<String> authenticateAPI(String username, String password) async {
    try {
      Response<dynamic> authenticateDB =
          await _dio.post("http://192.168.0.100:8000/findroom/authenticate",
              data: {
                "name": username,
                "password": password,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
      authenDB = authenticateDB.toString();
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
    return authenDB!;
  }
}
