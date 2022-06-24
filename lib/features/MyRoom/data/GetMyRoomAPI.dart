import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:dio/dio.dart';

class MyRoomAPI {
  final Dio _dio = Dio();
  var listRoom;
  Future<List<RoomModel>> getMyRoom(String idUser) async {
    try {
      Response myRoomData = await _dio.get(
        "https://findroomapi.herokuapp.com/findroom/room/user/$idUser",
      );

      print('My room: ${myRoomData}');
      var roomData = myRoomData.data as List;
      listRoom = roomData.map((e) => RoomModel.fromJson(e)).toList();
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
    return listRoom;
  }
}
