// import 'package:clean_achitecture/features/Post/domain/model/ward.dart';
// import 'package:equatable/equatable.dart';

// class District extends Equatable {
//   District({
//     required this.id_District,
//     required this.name,
//     //required this.type,
//   });

//   String id_District;
//   String name;
//   //Type type;

//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }
// //enum Type { QUN, THNH_PH, HUYN }

import 'dart:convert';

class District {
  District({
    // ignore: non_constant_identifier_names
    required this.id_District,
    required this.name,
    required this.type,
  });

  String id_District;
  String name;
  Type type;
  static District fromJson(json) => District(
        id_District: json['id_District'],
        name: json['name'],
        type: json['type'],
      );
}

enum Type { QUN, THNH_PH, HUYN }
