import 'package:flutter/material.dart';

ValueNotifier<List<KeepingModel>> currentKeepings =
    ValueNotifier(<KeepingModel>[]);

class KeepingModel {
  late int id = 0;
  // ignore: non_constant_identifier_names
  late String room_name = '';
  late int checked = 0;
  late String position = '';
  late String status = '';

  KeepingModel();

  KeepingModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] ?? 0;
      checked = jsonMap['done'] ?? 0;
      position = jsonMap['position'] ?? '';
      status = jsonMap['status'] ?? '';

      // ignore: empty_catches
    } catch (value) {}
  }
}
