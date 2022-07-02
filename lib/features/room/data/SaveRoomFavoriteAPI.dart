import 'dart:convert';

import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:dio/dio.dart';

class SaveFavoriteRoomAPI {
  final Dio _dio = Dio();
  var listRoom;
  Future<void> saveFavoriteRoom(RoomModel model, String idUser) async {
    var test = json.encode(model);
    try {
      Response roomPost = await _dio.post(
          "https://findroomapi.herokuapp.com/findroom/favoriteRoom/$idUser",
          data: model.toJson());

      print('Save room: ${roomPost}');
      var roomData = roomPost.data;
      listRoom = RoomModel.fromJson(roomData);
      print('post');
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
  }
}
