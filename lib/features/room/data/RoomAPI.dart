import 'dart:convert';

import 'package:clean_achitecture/features/room/model/RoomModel.dart';
import 'package:dio/dio.dart';

class RoomAPI {
  final Dio _dio = Dio();
  List<RoomModel>? roomModel;
  var listRoom;
  Future<List<RoomModel>> getListRoom() async {
    try {
      Response roomList =
          await _dio.get("https://findroomapi.herokuapp.com/findroom/room");

      print('User Info: ${roomList}');
      var getUsersData = roomList.data as List;
      listRoom = getUsersData.map((e) => RoomModel.fromJson(e)).toList();
      print('aaaa');
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
