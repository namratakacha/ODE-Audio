

class ProfileUpdateModel {
  final Settings? settings;
  final Data? data;

  ProfileUpdateModel({
    this.settings,
    this.data,
  });

  ProfileUpdateModel.fromJson(Map<String, dynamic> json)
      : settings = (json['settings'] as Map<String,dynamic>?) != null ? Settings.fromJson(json['settings'] as Map<String,dynamic>) : null,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'settings' : settings?.toJson(),
    'data' : data?.toJson()
  };
}

class Settings {
  final int? status;
  final String? message;
  final int? code;

  Settings({
    this.status,
    this.message,
    this.code,
  });

  Settings.fromJson(Map<String, dynamic> json)
      : status = json['status'] as int?,
        message = json['message'] as String?,
        code = json['code'] as int?;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'code' : code
  };
}

class Data {
  final int? id;
  final String? name;
  final String? dialCode;
  final dynamic profileImage;
  final String? email;
  final String? phoneNumber;
  final int? isVerified;
  final int? isGenresVisited;
  final int? isProfileCompleted;
  final int? isSocial;
  final String? userType;
  final String? gender;
  final dynamic facebookId;
  final dynamic appleId;
  final dynamic googleId;
  final int? enablePush;
  final String? deviceType;
  final dynamic deviceToken;
  final dynamic lastLogin;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final String? profileimageUrl;
  final String? profileimageThumbUrl;

  Data({
    this.id,
    this.name,
    this.dialCode,
    this.profileImage,
    this.email,
    this.phoneNumber,
    this.isVerified,
    this.isGenresVisited,
    this.isProfileCompleted,
    this.isSocial,
    this.userType,
    this.gender,
    this.facebookId,
    this.appleId,
    this.googleId,
    this.enablePush,
    this.deviceType,
    this.deviceToken,
    this.lastLogin,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.profileimageUrl,
    this.profileimageThumbUrl,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        dialCode = json['dial_code'] as String?,
        profileImage = json['profile_image'],
        email = json['email'] as String?,
        phoneNumber = json['phone_number'] as String?,
        isVerified = json['is_verified'] as int?,
        isGenresVisited = json['is_genres_visited'] as int?,
        isProfileCompleted = json['is_profile_completed'] as int?,
        isSocial = json['is_social'] as int?,
        userType = json['user_type'] as String?,
        gender = json['gender'] as String?,
        facebookId = json['facebook_id'],
        appleId = json['apple_id'],
        googleId = json['google_id'],
        enablePush = json['enable_push'] as int?,
        deviceType = json['device_type'] as String?,
        deviceToken = json['device_token'],
        lastLogin = json['last_login'],
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        profileimageUrl = json['profileimage_url'] as String?,
        profileimageThumbUrl = json['profileimage_thumb_url'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'dial_code' : dialCode,
    'profile_image' : profileImage,
    'email' : email,
    'phone_number' : phoneNumber,
    'is_verified' : isVerified,
    'is_genres_visited' : isGenresVisited,
    'is_profile_completed' : isProfileCompleted,
    'is_social' : isSocial,
    'user_type' : userType,
    'gender' : gender,
    'facebook_id' : facebookId,
    'apple_id' : appleId,
    'google_id' : googleId,
    'enable_push' : enablePush,
    'device_type' : deviceType,
    'device_token' : deviceToken,
    'last_login' : lastLogin,
    'status' : status,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'profileimage_url' : profileimageUrl,
    'profileimage_thumb_url' : profileimageThumbUrl,
  };
}