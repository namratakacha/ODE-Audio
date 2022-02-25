class DashBoardModel {
  String imageName;
  bool isSelected;

  DashBoardModel(this.imageName, this.isSelected);
}

List<DashBoardModel> imageList = [
  DashBoardModel('assets/images/temp/dashboard_genres_one.jpg', false),
  DashBoardModel('assets/images/temp/dashboard_genres_two.jpg', false),
  DashBoardModel('assets/images/temp/dashboard_genres_three.png', false),
  DashBoardModel('assets/images/temp/dashboard_genres_four.jpg', false),
  DashBoardModel('assets/images/temp/dashboard_genres_five.jpg', false),
  DashBoardModel('assets/images/temp/dashboard_genres_six.jpg', false)
];
