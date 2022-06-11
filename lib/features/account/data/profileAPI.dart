import 'package:dio/dio.dart';

class ProfileAPI {
  final Dio _dio = Dio();
  String? name;
  Future<String> getProfileAPI(String token) async {
    try {
      Response<dynamic> profileDB =
          await _dio.get("http://192.168.0.100:8000/findroom/getinfo",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              }));
      print(profileDB);
      name = profileDB.data["msg"].toString();
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
    return name!;
  }
}
