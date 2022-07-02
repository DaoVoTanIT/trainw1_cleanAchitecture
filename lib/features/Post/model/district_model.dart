import 'package:clean_achitecture/features/Post/model/distric.dart';

class DistrictModel extends District {
  DistrictModel({
    required String id_District,
    required String name,
  }) : super(id_District: id_District, name: name);

  static DistrictModel fromJson(json) => DistrictModel(
        id_District: json['id_DistrictModel'],
        name: json['name'],
        //type: json['type'],
      );
}

enum Type { QUN, THNH_PH, HUYN }
