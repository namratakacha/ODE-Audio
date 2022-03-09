import 'dart:convert';

AllGenresModel allGenresModelFromJson(String str) => AllGenresModel.fromJson(json.decode(str));

String allGenresModelToJson(AllGenresModel data) => json.encode(data.toJson());

class AllGenresModel {
  AllGenresModel({
    this.settings,
    this.data,
  });

  Settings? settings;
  List<Data>? data;

  factory AllGenresModel.fromJson(Map<String, dynamic> json) => AllGenresModel(
    settings: Settings.fromJson(json["settings"]),
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "settings": settings?.toJson(),
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.profileimageUrl,
    this.profileimageThumbUrl,
  });

  int? id;
  String? name;
  String? profileImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profileimageUrl;
  String? profileimageThumbUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    profileImage: json["profile_image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    profileimageUrl: json["profileimage_url"],
    profileimageThumbUrl: json["profileimage_thumb_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_image": profileImage,
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
    "profileimage_url": profileimageUrl,
    "profileimage_thumb_url": profileimageThumbUrl,
  };
}

class Settings {
  Settings({
    this.status,
    this.message,
    this.code,
  });

  int? status;
  String? message;
  int? code;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    status: json["status"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
  };
}







// class DashBoardModel {
//   String imageName;
//   bool isSelected;
//
//   DashBoardModel(this.imageName, this.isSelected);
// }
//
// List<DashBoardModel> imageList = [
//   DashBoardModel('assets/images/temp/dashboard_genres_one.jpg', false),
//   DashBoardModel('assets/images/temp/dashboard_genres_two.jpg', false),
//   DashBoardModel('assets/images/temp/dashboard_genres_three.png', false),
//   DashBoardModel('assets/images/temp/dashboard_genres_four.jpg', false),
//   DashBoardModel('assets/images/temp/dashboard_genres_five.jpg', false),
//   DashBoardModel('assets/images/temp/dashboard_genres_six.jpg', false)
// ];
// class AllGenresModel {
//   final Settings? settings;
//   final List<Data>? data;
//
//   AllGenresModel({
//     this.settings,
//     this.data,
//   });
//
//   AllGenresModel.fromJson(Map<String, dynamic> json)
//       : settings = (json['settings'] as Map<String,dynamic>?) != null ? Settings.fromJson(json['settings'] as Map<String,dynamic>) : null,
//         data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();
//
//   Map<String, dynamic> toJson() => {
//     'settings' : settings?.toJson(),
//     'data' : data?.map((e) => e.toJson()).toList()
//   };
// }
//
// class Settings {
//   final int? status;
//   final String? message;
//   final int? code;
//
//   Settings({
//     this.status,
//     this.message,
//     this.code,
//   });
//
//   Settings.fromJson(Map<String, dynamic> json)
//       : status = json['status'] as int?,
//         message = json['message'] as String?,
//         code = json['code'] as int?;
//
//   Map<String, dynamic> toJson() => {
//     'status' : status,
//     'message' : message,
//     'code' : code
//   };
// }
//
// class Data {
//   final int? id;
//   final String? name;
//   final String? profileImage;
//   final String? createdAt;
//   final String? updatedAt;
//   final String? profileimageUrl;
//   final String? profileimageThumbUrl;
//   final bool? isSelected;
//
//   Data({
//     this.id,
//     this.name,
//     this.profileImage,
//     this.createdAt,
//     this.updatedAt,
//     this.profileimageUrl,
//     this.profileimageThumbUrl,
//     this.isSelected,
//   });
//
//   Data.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         name = json['name'] as String?,
//         profileImage = json['profile_image'] as String?,
//         createdAt = json['created_at'] as String?,
//         updatedAt = json['updated_at'] as String?,
//         profileimageUrl = json['profileimage_url'] as String?,
//         profileimageThumbUrl = json['profileimage_thumb_url'] as String?,
//         isSelected = json['is_selected'] as bool?;
//
//   Map<String, dynamic> toJson() => {
//     'id' : id,
//     'name' : name,
//     'profile_image' : profileImage,
//     'created_at' : createdAt,
//     'updated_at' : updatedAt,
//     'profileimage_url' : profileimageUrl,
//     'profileimage_thumb_url' : profileimageThumbUrl,
//     'is_selected' : isSelected,
//   };
//}