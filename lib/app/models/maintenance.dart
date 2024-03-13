// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:newhonekapp/app/models/user.dart';

ValueNotifier<List<UserModel>> currentMainteners = ValueNotifier(<UserModel>[]);
ValueNotifier<List<MaintenancesModel>> currentMaintenances =
    ValueNotifier(<MaintenancesModel>[]);

class MaintenancesModel {
  late int id = 0;
  late int author_id = 0;
  late String reason = '';
  late int room_id = 0;
  late String status = '';
  late int priority = 0;
  late int user_id = 0;
  late String notes = '';
  late String room_name = '';

  MaintenancesModel();

  MaintenancesModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] ?? '';
      author_id = jsonMap['author_id'] ?? '';
      reason = jsonMap['reason'] ?? '';
      room_id = jsonMap['room_id'] ?? 0;
      status = jsonMap['status'] ?? '';
      priority = jsonMap['priority'] ?? 0;
      user_id = jsonMap['user_id'] ?? 0;
      notes = jsonMap['notes'] ?? '';
    // ignore: empty_catches
    } catch (value) {}
  }
}
