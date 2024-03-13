import 'package:flutter/cupertino.dart';

ValueNotifier<List<FoodAndBeverageModel>> currentFoods =
    ValueNotifier(<FoodAndBeverageModel>[]);
ValueNotifier<List<FoodAndBeverageModel>> currentBeverages =
    ValueNotifier(<FoodAndBeverageModel>[]);

ValueNotifier<List<FoodAndBeverageModel>> currentCart =
    ValueNotifier(<FoodAndBeverageModel>[]);

ValueNotifier<List<FoodAndBeverageModel>> currentFrigoBarSale =
    ValueNotifier(<FoodAndBeverageModel>[]);

ValueNotifier<List<FoodAndBeverageModel>> currentBarSale =
    ValueNotifier(<FoodAndBeverageModel>[]);

class FoodAndBeverageModel {
  late int id = 0;
  late String name = '';
  late int idcategory = 0;
  late String price = '';
  late int quantity = 0;
  late String description = '';
  late int salebar = 0;
  late int salefrigobar = 0;
  late String image = '';
  late int status = 0;
  late int authorid = 0;
  late String nameStructure = '';

  FoodAndBeverageModel();

  FoodAndBeverageModel.fromJSON(
      Map<String, dynamic> jsonMap, String nameStructuree) {
    try {
      id = jsonMap['id'] ?? '';
      name = jsonMap['name'] ?? '';
      idcategory = jsonMap['id_category'] ?? 0;
      price = jsonMap['price'] ?? '';
      quantity = jsonMap['quantity'] ?? 0;
      description = jsonMap['description'] ?? '';
      salebar = jsonMap['sale_bar'] ?? 0;
      salefrigobar = jsonMap['sale_frigobar'] ?? 0;
      image = jsonMap['image'] ?? '';
      status = jsonMap['status'] ?? 0;
      authorid = jsonMap['author_id'] ?? 0;
      nameStructure = nameStructuree;
    // ignore: empty_catches
    } catch (value) {}
  }
}



List<String> foodCategories = [
  "Carne",
  "Latte e derivati",
  "Cereali",
  "Ortaggi",
  "Fruta",
  "Pesce",
  "Uova"
];
List<String> beverageCategories = [
  "Acqua",
  "Alcolici",
  "Analcolici",
  "Bibite",
  "Bibite gassate",
  "Superalcolici",
  "Altro"
];
