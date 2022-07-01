import 'dart:convert';

import 'package:clean_achitecture/features/room/model/CommentModel.dart';
import 'package:dio/dio.dart';

class CommentRoomAPI {
  final Dio _dio = Dio();
  var comment;
  List<CommentModel>? listCommentModel;

  Future<CommentModel> createCommentRoom(CommentModel model) async {
    try {
      Response roomPost = await _dio.post(
          "https://findroomapi.herokuapp.com/findroom/comment",
          data: model.toJson());

      print('User Info: ${roomPost}');
      var roomData = roomPost.data;
      var test = json.encode(roomData);
      comment = CommentModel.fromJson(roomData);
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
    return comment;
  }

  Future<List<CommentModel>?> getListComment() async {
    try {
      Response roomList =
          await _dio.get("https://findroomapi.herokuapp.com/findroom/comment");

      print('User Info: ${roomList}');
      var getUsersData = roomList.data as List;
      listCommentModel =
          getUsersData.map((e) => CommentModel.fromJson(e)).toList();
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
    return listCommentModel;
  }
}
