import 'dart:convert';

import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:dio/dio.dart';

class CreateRoomAPI {
  final Dio _dio = Dio();
  var listRoom;
  Future<RoomModel> createPostRoom(RoomModel model) async {
    try {
      Response roomPost = await _dio.post(
          "https://findroomapi.herokuapp.com/findroom/room",
          data: model.toJson());

      print('User Info: ${roomPost}');
      var roomData = roomPost.data;
      var test = json.encode(roomData);
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
    return listRoom;
  }
}
