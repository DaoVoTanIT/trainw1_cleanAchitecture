class CommentModel {
  CommentModel({
    this.id,
    this.idauthor,
    this.idroom,
    this.name,
    this.avatar,
    this.datetime,
    this.content,
  });

  String? id;
  String? idauthor;
  String? idroom;
  String? name;
  String? avatar;
  String? datetime;
  String? content;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["_id"],
        idauthor: json["idauthor"],
        idroom: json["idroom"],
        name: json["name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        datetime: json["datetime"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "idauthor": idauthor,
        "idroom": idroom,
        "name": name,
        "avatar": avatar == null ? null : avatar,
        "datetime": datetime,
        "content": content,
      };
}
