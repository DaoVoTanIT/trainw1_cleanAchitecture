// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.password,
    this.phone,
    this.address,
    this.birthday,
  });

  String? id;
  String? name;
  String? password;
  String? phone;
  String? address;
  String? birthday;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        phone: json["phone"],
        address: json["adress"],
        birthday: json["birthday"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "password": password,
        "phone": phone,
        "adress": address,
        "birthday": birthday,
      };
}
