import 'dart:convert';

import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:dio/dio.dart';

class SaveFavoriteRoomAPI {
  final Dio _dio = Dio();
  var listRoom;
  Future<void> saveFavoriteRoom(RoomModel model) async {
    try {
      Response roomPost = await _dio.post(
          "http://192.168.0.100:8000/findroom/favoriteRoom",
          data: model.toJson());

      print('Save rom: ${roomPost}');
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
