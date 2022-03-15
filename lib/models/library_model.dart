// class LibraryModel {
//   String recentImg;
//   String resentSongTitle;
//   String songTitle;
//   String subtitle;
//   String songImg;
//
//   LibraryModel(
//     this.recentImg,
//     this.resentSongTitle,
//     this.songImg,
//     this.songTitle,
//     this.subtitle,
//   );
// }
//
// List<LibraryModel> items = [
//   LibraryModel(
//     'assets/images/temp/library_recent_one.jpg',
//     'Sunlit Youth',
//     'assets/images/temp/library_songs_one.jpg',
//     'Old Town Road',
//     'Lli Nas X 2019',
//   ),
//   LibraryModel(
//     'assets/images/temp/library_recent_two.jpg',
//     'Mirage',
//     'assets/images/temp/library_songs_two.jpg',
//     'Dont Start Now',
//     'Dua Lia 2019',
//   ),
//   LibraryModel(
//     'assets/images/temp/library_recent_one.jpg',
//     'Sunlit Youth',
//     'assets/images/temp/library_songs_three.jpg',
//     'Old Town Road',
//     'Lli Nas X 2019',
//   ),
//   LibraryModel(
//     'assets/images/temp/library_recent_two.jpg',
//     'Mirage',
//     'assets/images/temp/library_songs_four.jpg',
//     'Dont Start Now',
//     'Dua Lia 2019',
//   ),
// ];

class AllSongsModel {
  final Settings? settings;
  final Data? data;

  AllSongsModel({
    this.settings,
    this.data,
  });

  AllSongsModel.fromJson(Map<String, dynamic> json)
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
  final List<dynamic>? recentlyPlayedSongs;
  final List<AllSongs>? allSongs;
  final int? nextPage;
  final int? currentPage;
  final int? total;

  Data({
    this.recentlyPlayedSongs,
    this.allSongs,
    this.nextPage,
    this.currentPage,
    this.total,
  });

  Data.fromJson(Map<String, dynamic> json)
      : recentlyPlayedSongs = json['recently_played_songs'] as List?,
        allSongs = (json['all_songs'] as List?)?.map((dynamic e) => AllSongs.fromJson(e as Map<String,dynamic>)).toList(),
        nextPage = json['next_page'] as int?,
        currentPage = json['current_page'] as int?,
        total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
    'recently_played_songs' : recentlyPlayedSongs,
    'all_songs' : allSongs?.map((e) => e.toJson()).toList(),
    'next_page' : nextPage,
    'current_page' : currentPage,
    'total' : total
  };
}

class AllSongs {
  final int? id;
  final String? songId;
  final String? songName;
  final String? artistName;
  final int? genre;
  final String? songUrl;
  final String? token;
  final String? duration;
  final String? image75;
  final String? image150;
  final String? image800;
  final String? createdAt;
  final String? updatedAt;
  final String? genreName;

  AllSongs({
    this.id,
    this.songId,
    this.songName,
    this.artistName,
    this.genre,
    this.songUrl,
    this.token,
    this.duration,
    this.image75,
    this.image150,
    this.image800,
    this.createdAt,
    this.updatedAt,
    this.genreName,
  });

  AllSongs.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        songId = json['song_id'] as String?,
        songName = json['song_name'] as String?,
        artistName = json['artist_name'] as String?,
        genre = json['genre'] as int?,
        songUrl = json['song_url'] as String?,
        token = json['token'] as String?,
        duration = json['duration'] as String?,
        image75 = json['image_75'] as String?,
        image150 = json['image_150'] as String?,
        image800 = json['image_800'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        genreName = json['genre_name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'song_id' : songId,
    'song_name' : songName,
    'artist_name' : artistName,
    'genre' : genre,
    'song_url' : songUrl,
    'token' : token,
    'duration' : duration,
    'image_75' : image75,
    'image_150' : image150,
    'image_800' : image800,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'genre_name' : genreName
  };
}
