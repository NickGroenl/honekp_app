import 'package:flutter/material.dart';

ValueNotifier<List<ServicesModel>> currentServices =
    ValueNotifier(<ServicesModel>[]);
ValueNotifier<List<ServicesModel>> currentServicesPriority =
    ValueNotifier(<ServicesModel>[]);
ValueNotifier<List<ServicesModel>> currentServicesNoPay =
    ValueNotifier(<ServicesModel>[]);
ValueNotifier<List<ServicesModel>> currentServicesCart =
    ValueNotifier(<ServicesModel>[]);

class ServicesModel {
  late int id = 0;
  // ignore: non_constant_identifier_names
  late int author_id = 0;
  late String name = '';
  late String description = '';
  late String image = '';
  late String phone = '';
  late String price = '';
  late String priority = '';
  late String address = '';
  late int status = 0;
  late String type = '';
  late String map = '';

  ServicesModel();

  ServicesModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] ?? 0;
      author_id = jsonMap['author_id'] ?? 0;
      name = jsonMap['name'] ?? '';
      status = jsonMap['status'] ?? '';
      description = jsonMap['description'] ?? '';
      image = jsonMap['image'] ?? '';
      phone = jsonMap['phone'] ?? '';
      price = jsonMap['price'] ?? '';
      priority = jsonMap['priority'] ?? '';
      address = jsonMap['address'] ?? '';
      type = jsonMap['type'] ?? '';
      map = jsonMap['map'] ?? '';
      // ignore: empty_catches
    } catch (value) {}
  }
}
