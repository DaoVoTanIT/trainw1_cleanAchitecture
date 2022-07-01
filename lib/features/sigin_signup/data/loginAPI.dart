import 'package:clean_achitecture/LocalStoreKey.dart';
import 'package:clean_achitecture/common/Config.dart';
import 'package:dio/dio.dart';
import 'package:localstorage/localstorage.dart';

class LoginAPI {
  final Dio _dio = Dio();
  String? token;
  String? name;
  final LocalStorage storage = new LocalStorage(keyLocalStore);

  Future<String> authenticateAPI(String username, String password) async {
    try {
      Response<dynamic> _result = await _dio.post(
          "https://findroomapi.herokuapp.com/findroom/authenticate",
          data: {
            "name": username,
            "password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      if (_result.statusCode == 400) return "";
      token = _result.data!["token"].toString();
      String idUser = _result.data!['user']["_id"].toString();
      String nameUser = _result.data!['user']["name"].toString();

      storage.setItem(LocalStoreKey.idUser, idUser);
      storage.setItem(LocalStoreKey.name, nameUser);

      print(storage.getItem(LocalStoreKey.idUser));
      // Response<dynamic> _result =
      //     await _dio.get("https://findroomapi.herokuapp.com/findroom/getinfo",
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
