// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

ValueNotifier<List<ShopsModel>> currentShops = ValueNotifier(<ShopsModel>[]);
ValueNotifier<List<ShopsModel>> currentShopsServices = ValueNotifier(<ShopsModel>[]);


class ShopsModel {
  late int id = 0;
  late String title = '';
  late String price = '0';
  late String image = '';
  late int user_id = 0;
  late int product_id = 0;

  ShopsModel();

  ShopsModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] ?? '';
      title = jsonMap['title'] ?? '';
      price = jsonMap['price'] ?? 0;
      image = jsonMap['image'] ?? '';
      product_id = jsonMap['product_id'] ?? 0;
      user_id = jsonMap['user_id'] ?? 0;
    // ignore: empty_catches
    } catch (value) {}
  }
}
