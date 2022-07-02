class District {
  District({
    // ignore: non_constant_identifier_names
    required this.id_District,
    required this.name,
  });

  String id_District;
  String name;
  static District fromJson(json) => District(
        id_District: json['id_District'],
        name: json['name'],
      );
}

enum Type { QUN, THNH_PH, HUYN }
