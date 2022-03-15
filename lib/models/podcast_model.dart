// class PodcastModel {
//   String podcastTrendingImg;
//   String podcastTrendingTitle;
//   String podcastTrendingSubtitle;
//   String podcastFeaturedImg;
//   String podcastFeaturedTitle;
//   String podcastFeaturedSubtitle;
//
//   PodcastModel(
//       this.podcastTrendingImg,
//       this.podcastTrendingTitle,
//       this.podcastTrendingSubtitle,
//       this.podcastFeaturedImg,
//       this.podcastFeaturedTitle,
//       this.podcastFeaturedSubtitle);
// }
//
// List<PodcastModel> items = [
//   PodcastModel(
//       'assets/images/temp/podcast_trending_one.JPG',
//       'Hard Truth',
//       'African Milienials',
//       'assets/images/temp/podcast_featured_one.JPG',
//       'Sucess Exress',
//       'TED Talks'),
//   PodcastModel(
//       'assets/images/temp/podcast_trending_two.JPG',
//       'What to exect next',
//       'R&B on Sorts',
//       'assets/images/temp/podcast_featured_two.JPG',
//       'Jazz in the 80s',
//       'Riffin on Jazz'),
//   PodcastModel(
//       'assets/images/temp/podcast_trending_one.JPG',
//       'Hard Truth',
//       'African Milienials',
//       'assets/images/temp/podcast_featured_one.JPG',
//       'Sucess Exress',
//       'TED Talks'),
//   PodcastModel(
//       'assets/images/temp/podcast_trending_two.JPG',
//       'What to exect next',
//       'R&B on Sorts',
//       'assets/images/temp/podcast_featured_two.JPG',
//       'Jazz in the 80s',
//       'Riffin on Jazz'),
// ];


class PodcastModel {
  final Settings? settings;
  final Data? data;

  PodcastModel({
    this.settings,
    this.data,
  });

  PodcastModel.fromJson(Map<String, dynamic> json)
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
  final List<TrandingPodcasts>? trandingPodcasts;
  final List<FeaturedPodcasts>? featuredPodcasts;

  Data({
    this.trandingPodcasts,
    this.featuredPodcasts,
  });

  Data.fromJson(Map<String, dynamic> json)
      : trandingPodcasts = (json['tranding_podcasts'] as List?)?.map((dynamic e) => TrandingPodcasts.fromJson(e as Map<String,dynamic>)).toList(),
        featuredPodcasts = (json['featured_podcasts'] as List?)?.map((dynamic e) => FeaturedPodcasts.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'tranding_podcasts' : trandingPodcasts?.map((e) => e.toJson()).toList(),
    'featured_podcasts' : featuredPodcasts?.map((e) => e.toJson()).toList()
  };
}

class TrandingPodcasts {
  final int? id;
  final String? name;
  final int? generId;
  final String? shortDescription;
  final String? profileImage;
  final String? audio;
  final int? isTranding;
  final int? isFeatured;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final String? genreName;
  final String? audioUrl;
  final String? profileimageUrl;
  final String? profileimageThumbUrl;

  TrandingPodcasts({
    this.id,
    this.name,
    this.generId,
    this.shortDescription,
    this.profileImage,
    this.audio,
    this.isTranding,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.genreName,
    this.audioUrl,
    this.profileimageUrl,
    this.profileimageThumbUrl,
  });

  TrandingPodcasts.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        generId = json['gener_id'] as int?,
        shortDescription = json['short_description'] as String?,
        profileImage = json['profile_image'] as String?,
        audio = json['audio'] as String?,
        isTranding = json['is_tranding'] as int?,
        isFeatured = json['is_featured'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        genreName = json['genre_name'] as String?,
        audioUrl = json['audio_url'] as String?,
        profileimageUrl = json['profileimage_url'] as String?,
        profileimageThumbUrl = json['profileimage_thumb_url'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'gener_id' : generId,
    'short_description' : shortDescription,
    'profile_image' : profileImage,
    'audio' : audio,
    'is_tranding' : isTranding,
    'is_featured' : isFeatured,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'genre_name' : genreName,
    'audio_url' : audioUrl,
    'profileimage_url' : profileimageUrl,
    'profileimage_thumb_url' : profileimageThumbUrl
  };
}

class FeaturedPodcasts {
  final int? id;
  final String? name;
  final int? generId;
  final String? shortDescription;
  final String? profileImage;
  final String? audio;
  final int? isTranding;
  final int? isFeatured;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final String? genreName;
  final String? audioUrl;
  final String? profileimageUrl;
  final String? profileimageThumbUrl;

  FeaturedPodcasts({
    this.id,
    this.name,
    this.generId,
    this.shortDescription,
    this.profileImage,
    this.audio,
    this.isTranding,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.genreName,
    this.audioUrl,
    this.profileimageUrl,
    this.profileimageThumbUrl,
  });

  FeaturedPodcasts.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        generId = json['gener_id'] as int?,
        shortDescription = json['short_description'] as String?,
        profileImage = json['profile_image'] as String?,
        audio = json['audio'] as String?,
        isTranding = json['is_tranding'] as int?,
        isFeatured = json['is_featured'] as int?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'],
        genreName = json['genre_name'] as String?,
        audioUrl = json['audio_url'] as String?,
        profileimageUrl = json['profileimage_url'] as String?,
        profileimageThumbUrl = json['profileimage_thumb_url'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'gener_id' : generId,
    'short_description' : shortDescription,
    'profile_image' : profileImage,
    'audio' : audio,
    'is_tranding' : isTranding,
    'is_featured' : isFeatured,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'genre_name' : genreName,
    'audio_url' : audioUrl,
    'profileimage_url' : profileimageUrl,
    'profileimage_thumb_url' : profileimageThumbUrl
  };
}


