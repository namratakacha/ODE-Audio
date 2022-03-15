class RecentlySearchSongModel {
  final Settings? settings;
  final Data? data;

  RecentlySearchSongModel({
    this.settings,
    this.data,
  });

  RecentlySearchSongModel.fromJson(Map<String, dynamic> json)
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
  final List<RecentlySearchSongs>? recentlySearchSongs;
  final int? nextPage;
  final int? currentPage;
  final int? total;

  Data({
    this.recentlySearchSongs,
    this.nextPage,
    this.currentPage,
    this.total,
  });

  Data.fromJson(Map<String, dynamic> json)
      : recentlySearchSongs = (json['recently_search_songs'] as List?)?.map((dynamic e) => RecentlySearchSongs.fromJson(e as Map<String,dynamic>)).toList(),
        nextPage = json['next_page'] as int?,
        currentPage = json['current_page'] as int?,
        total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
    'recently_search_songs' : recentlySearchSongs?.map((e) => e.toJson()).toList(),
    'next_page' : nextPage,
    'current_page' : currentPage,
    'total' : total
  };
}

class RecentlySearchSongs {
  final int? id;
  final String? songName;
  final String? image75;
  final String? image150;
  final String? image800;

  RecentlySearchSongs({
    this.id,
    this.songName,
    this.image75,
    this.image150,
    this.image800,
  });

  RecentlySearchSongs.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        songName = json['song_name'] as String?,
        image75 = json['image_75'] as String?,
        image150 = json['image_150'] as String?,
        image800 = json['image_800'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'song_name' : songName,
    'image_75' : image75,
    'image_150' : image150,
    'image_800' : image800
  };
}