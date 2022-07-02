class Ward {
  Ward({
    required this.idWard,
    required this.name,
    required this.type,
    required this.idDistrict,
  });

  String idWard;
  String name;
  Type type;
  String idDistrict;
  // static Ward fromJson(json) => Ward(
  //       idWard: json['id_Ward'],
  //       name: json['name'],
  //       type: json['type'],
  //       idDistrict: json['id_District'],
  //     );
  static Ward fromJson(json) => Ward(
        idWard: json['id_District'],
        name: json['name'],
        type: json['type'],
        idDistrict: json['id_District'],
      );
}

enum Type { PHNG, TH_TRN, X }
