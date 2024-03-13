class TravelsModel {
  final String title;
  final String description;
  final String ubication;
  final String price;
  final String imagepath;

  TravelsModel(
      {required this.title,
      required this.description,
      required this.ubication,
      required this.price,
      required this.imagepath});
}

class CategoriesModel {
  final String title;

  CategoriesModel({required this.title});
}


class FoodListModel {
  final String title;
  final String time;
  final String hotel;
  final String price;
  final String imagepath;
  final String description;

  FoodListModel(
      {required this.title,
      required this.time,
      required this.price,
      required this.imagepath,
      required this.hotel,
      required this.description});
}
