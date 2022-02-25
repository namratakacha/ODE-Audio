class PodcastModel {
  String podcastTrendingImg;
  String podcastTrendingTitle;
  String podcastTrendingSubtitle;
  String podcastFeaturedImg;
  String podcastFeaturedTitle;
  String podcastFeaturedSubtitle;

  PodcastModel(
      this.podcastTrendingImg,
      this.podcastTrendingTitle,
      this.podcastTrendingSubtitle,
      this.podcastFeaturedImg,
      this.podcastFeaturedTitle,
      this.podcastFeaturedSubtitle);
}

List<PodcastModel> items = [
  PodcastModel(
      'assets/images/temp/podcast_trending_one.JPG',
      'Hard Truth',
      'African Milienials',
      'assets/images/temp/podcast_featured_one.JPG',
      'Sucess Exress',
      'TED Talks'),
  PodcastModel(
      'assets/images/temp/podcast_trending_two.JPG',
      'What to exect next',
      'R&B on Sorts',
      'assets/images/temp/podcast_featured_two.JPG',
      'Jazz in the 80s',
      'Riffin on Jazz'),
  PodcastModel(
      'assets/images/temp/podcast_trending_one.JPG',
      'Hard Truth',
      'African Milienials',
      'assets/images/temp/podcast_featured_one.JPG',
      'Sucess Exress',
      'TED Talks'),
  PodcastModel(
      'assets/images/temp/podcast_trending_two.JPG',
      'What to exect next',
      'R&B on Sorts',
      'assets/images/temp/podcast_featured_two.JPG',
      'Jazz in the 80s',
      'Riffin on Jazz'),
];
