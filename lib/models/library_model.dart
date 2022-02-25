class LibraryModel {
  String recentImg;
  String resentSongTitle;
  String songTitle;
  String subtitle;
  String songImg;

  LibraryModel(
    this.recentImg,
    this.resentSongTitle,
    this.songImg,
    this.songTitle,
    this.subtitle,
  );
}

List<LibraryModel> items = [
  LibraryModel(
    'assets/images/temp/library_recent_one.jpg',
    'Sunlit Youth',
    'assets/images/temp/library_songs_one.jpg',
    'Old Town Road',
    'Lli Nas X 2019',
  ),
  LibraryModel(
    'assets/images/temp/library_recent_two.jpg',
    'Mirage',
    'assets/images/temp/library_songs_two.jpg',
    'Dont Start Now',
    'Dua Lia 2019',
  ),
  LibraryModel(
    'assets/images/temp/library_recent_one.jpg',
    'Sunlit Youth',
    'assets/images/temp/library_songs_three.jpg',
    'Old Town Road',
    'Lli Nas X 2019',
  ),
  LibraryModel(
    'assets/images/temp/library_recent_two.jpg',
    'Mirage',
    'assets/images/temp/library_songs_four.jpg',
    'Dont Start Now',
    'Dua Lia 2019',
  ),
];
