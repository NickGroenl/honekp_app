import 'package:flutter/cupertino.dart';

ValueNotifier<RoomModel> currentRoom = ValueNotifier(RoomModel());
ValueNotifier<List<RoomModel>> currentRooms = ValueNotifier(<RoomModel>[]);
class RoomModel {
  String id = '';
  String name = '';
  String ip = '';

  bool state = false;
  bool isAvailable = false;
  int countdown = 10;
  String buttonText = 'Apri Camera';

  RoomModel();
  RoomModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      ip = jsonMap['ip_address'] ?? '';
      name = jsonMap['name'] ?? '';
    } catch (e) {
      id = '';
      name = '';
      ip = '';
    }
  }
}
