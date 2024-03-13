import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:cache_manager/cache_manager.dart';
import 'package:newhonekapp/app/models/keeping.dart';
import 'constants.dart';

Future<bool> getKeepings() async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.get(Uri.parse('$baseUrl/keeping/get'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      "authorization": authorizationKey,
      "Cookie": 'access_token=$session',
    });
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['data'];
      getCurrentKeepings(currentKeepings.value =
          rss.map((e) => KeepingModel.fromJSON(e)).toList());
      return true;
    }
  }
  return false;
}

Future<bool> updateKeepingStatus(Object body) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.post(Uri.parse('$baseUrl/keeping/update/status'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              "authorization": authorizationKey,
              "Cookie": 'access_token=$session',
            },
            body: jsonEncode(body));
    print(response.body);
    if (response.statusCode == 202) {
      return true;
    }
  }
  return false;
}

Future getCurrentKeepings(List<KeepingModel> keepings) async {
  // ignore: prefer_typing_uninitialized_variables
  late List<KeepingModel> castKeepings = [];
  var response;
  for (var i = 0; i < keepings.length; i++) {
    if (keepings[i].id != 0) {
      response = await getKeepingById(keepings[i].id);
      keepings[i].room_name = response['keeping']['room_data']['name'] ?? '';
      castKeepings.add(keepings[i]);
    }
  }
  currentKeepings.value = castKeepings;
}

Future getKeepingById(id) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();

    final response = await client.post(Uri.parse('$baseUrl/keeping/getbyid'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: jsonEncode({"id": id}));
    if (response.statusCode == 202) {
      return json.decode(response.body);
    }
  }
}
