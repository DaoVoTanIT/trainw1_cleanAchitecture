import 'package:clean_achitecture/features/sigin_signup/model/user.dart';
import 'package:dio/dio.dart';

class ProfileAPI {
  final Dio _dio = Dio();
  String? name;
  User? user;
  Future<User> getProfileAPI(String token) async {
    try {
      Response<dynamic> profileDB =
          await _dio.get("https://findroomapi.herokuapp.com/findroom/getinfo",
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer $token',
              }));
      print(profileDB);
      var getUsersData = profileDB.data;
      user = User.fromJson(getUsersData);
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
    return user!;
  }
}
