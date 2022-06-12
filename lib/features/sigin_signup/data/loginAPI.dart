import 'package:dio/dio.dart';

class LoginAPI {
  final Dio _dio = Dio();
  String? token;
  String? name;
  Future<String> authenticateAPI(String username, String password) async {
    try {
      Response<dynamic> _result =
          await _dio.post("http://192.168.0.100:8000/findroom/authenticate",
              data: {
                "name": username,
                "password": password,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
      if (_result.statusCode == 400) return "";
      token = _result.data!["token"].toString();
      // Response<dynamic> _result =
      //     await _dio.get("http://192.168.0.100:8000/findroom/getinfo",
      //         options: Options(headers: {
      //           'Authorization': 'Bearer $token',
      //         }));

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
    return token!;
  }
}