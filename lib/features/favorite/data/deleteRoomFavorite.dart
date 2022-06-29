import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:dio/dio.dart';

class DeleteFavoriteRoomAPI {
  final Dio _dio = Dio();
  List<RoomModel>? roomModel;
  var listRoom;
  Future<RoomModel> deleteFavoriteRoom(String idRoomFavorire) async {
    try {
      Response deleteRoom = await _dio.delete(
          "https://findroomapi.herokuapp.com/findroom/favoriteRoom/delete/$idRoomFavorire");
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
