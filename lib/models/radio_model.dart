class RadioModel {
  String radioImg;
  String radioTitle;
  String radioSubtitle;
  String artistImg;
  String artistTitle;

  RadioModel(this.radioImg, this.radioTitle, this.radioSubtitle, this.artistImg,
      this.artistTitle);
}

List<RadioModel> items = [
  RadioModel(
      'assets/images/temp/radio_fm_one.PNG',
      'KJLH 102.3FM',
      'Serving the Los Angles Urben',
      'assets/images/temp/radio_artist_one.PNG',
      'Drake'),
  RadioModel(
      'assets/images/temp/radio_fm_two.PNG',
      'WHUR 96.3',
      'The best of DC Radio',
      'assets/images/temp/radio_artist_two.PNG',
      'Travis Scott'),
  RadioModel(
      'assets/images/temp/radio_fm_one.PNG',
      'KJLH 102.3FM',
      'Serving the Los Angles Urben',
      'assets/images/temp/radio_artist_one.PNG',
      'Drake'),
  RadioModel(
      'assets/images/temp/radio_fm_two.PNG',
      'WHUR 96.3',
      'The best of DC Radio',
      'assets/images/temp/radio_artist_two.PNG',
      'Travis Scott'),
];
