class SearchSongModel {
  String songImg;
  String songTitle;
  String songSubtitle;

  SearchSongModel(this.songImg, this.songTitle, this.songSubtitle);
}

List<SearchSongModel> songs = [
  SearchSongModel(
    'assets/images/temp/search_song_one.jpg',
    'Bruno Mars',
    'Artist',
  ),
  SearchSongModel(
    'assets/images/temp/search_song_two.jpg',
    'Believer',
    'Imagine Dragons',
  ),
  SearchSongModel(
    'assets/images/temp/search_song_three.jpg',
    'Closer',
    'The Chainsmokers',
  ),
  SearchSongModel(
    'assets/images/temp/library_songs_one.jpg',
    'Old Town Road',
    'Lli Nas X 2019',
  ),
  SearchSongModel(
    'assets/images/temp/library_songs_two.jpg',
    'Dont Start Now',
    'Dua Lia 2019',
  ),
];
