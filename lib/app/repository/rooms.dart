import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:cache_manager/cache_manager.dart';
import '../models/bookings/room.dart';
import 'constants.dart';

Future<bool> getOpenDoorRooms(int author) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(Uri.parse('$baseUrl/roles/get/rooms'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: json.encode({"author_id": author}));
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['rooms'];
      currentRooms.value = rss.map((e) => RoomModel.fromJSON(e)).toList();
      return true;
    }
  }
  return false;
}
