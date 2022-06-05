class RoomModel {
  RoomModel(
      {this.id,
      this.accountId,
      this.accountName,
      this.adId,
      this.area,
      this.areaName,
      this.areaV2,
      this.avatar,
      this.body,
      this.category,
      this.categoryName,
      this.containVideos,
      this.date,
      this.imageMain,
      this.images,
      this.latitude,
      this.listId,
      this.listTime,
      this.longitude,
      this.numberOfImages,
      this.owner,
      this.price,
      this.priceString,
      this.region,
      this.regionName,
      this.regionV2,
      this.size,
      this.streetName,
      this.streetNumber,
      this.subject,
      this.typeName,
      this.ward,
      this.wardName,
      this.statusRoom});

  String? id;
  String? accountId;
  String? accountName;
  int? adId;
  int? area;
  String? areaName;
  int? areaV2;
  String? avatar;
  String? body;
  int? category;
  String? categoryName;
  int? containVideos;
  String? date;
  dynamic imageMain;
  List<String>? images;
  String? latitude;
  int? listId;
  int? listTime;
  String? longitude;
  int? numberOfImages;
  bool? owner;
  int? price;
  String? priceString;
  int? region;
  String? regionName;
  int? regionV2;
  int? size;
  String? streetName;
  String? streetNumber;
  String? subject;
  String? typeName;
  int? ward;
  String? wardName;
  int? statusRoom; //0 not save
  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        id: json["_id"],
        accountId: json["account_id"] as String,
        accountName: json["account_name"],
        adId: json["ad_id"],
        area: json["area"],
        areaName: json["area_name"],
        areaV2: json["area_v2"],
        avatar: json["avatar"],
        body: json["body"],
        category: json["category"],
        categoryName: json["category_name"],
        containVideos: json["contain_videos"],
        date: json["date"],
        imageMain: json["image_main"],
        images: List<String>.from(json["images"] ?? [].map((x) => x)),
        latitude: json["latitude"] as String,
        listId: json["list_id"],
        listTime: json["list_time"],
        longitude: json['longitude'] != "null" ? json['longitude'] : '0.0',
        numberOfImages: json["number_of_images"],
        owner: json["owner"],
        price: json["price"],
        priceString: json["price_string"],
        region: json["region"],
        regionName: json["region_name"],
        regionV2: json["region_v2"],
        size: json["size"],
        streetName: json["street_name"],
        streetNumber: json["street_number"],
        subject: json["subject"],
        typeName: json["type_name"],
        ward: json["ward"],
        wardName: json["ward_name"],
        statusRoom: json["status_room"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "account_id": accountId,
        "account_name": accountName,
        "ad_id": adId,
        "area": area,
        "area_name": areaName,
        "area_v2": areaV2,
        "avatar": avatar,
        "body": body,
        "category": category,
        "category_name": categoryName,
        "contain_videos": containVideos,
        "date": date,
        "image_main": imageMain,
        "images": List<dynamic>.from(images ?? [].map((x) => x)),
        "latitude": latitude,
        "list_id": listId,
        "list_time": listTime,
        "longitude": longitude,
        "number_of_images": numberOfImages,
        "owner": owner,
        "price": price,
        "price_string": priceString,
        "region": region,
        "region_name": regionName,
        "region_v2": regionV2,
        "size": size,
        "street_name": streetName,
        "street_number": streetNumber,
        "subject": subject,
        "type_name": typeName,
        "ward": ward,
        "ward_name": wardName,
        "status_room": statusRoom,
      };
}
