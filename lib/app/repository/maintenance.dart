import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:cache_manager/cache_manager.dart';
import 'package:newhonekapp/app/models/maintenance.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'constants.dart';

Future<bool> getMaintenances() async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client
        .get(Uri.parse('$baseUrl/maintenance/get/maintenances'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      "authorization": authorizationKey,
      "Cookie": 'access_token=$session',
    });

    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['maintenances'];
      currentMaintenances.value =
          rss.map((e) => MaintenancesModel.fromJSON(e)).toList();
      return true;
    }
  }
  return false;
}

Future<bool> getMainteners() async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client
        .get(Uri.parse('$baseUrl/maintenance/get/mainteners'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      "authorization": authorizationKey,
      "Cookie": 'access_token=$session',
    });

    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['mainteners'];
      currentMainteners.value = rss.map((e) => UserModel.fromJSON(e)).toList();
      return true;
    }
  }
  return false;
}

Future<bool> updateMaintenanceStatus(Object body) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.post(Uri.parse('$baseUrl/maintenance/update/status'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              "authorization": authorizationKey,
              "Cookie": 'access_token=$session',
            },
            body: jsonEncode(body));
    if (response.statusCode == 202) {
      return true;
    }
  }
  return false;
}

Future<bool> updateMaintenanceNotes(Object body) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.post(Uri.parse('$baseUrl/maintenance/update/notes'),
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

Future<bool> getMaintenancesByMaintener() async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.get(
        Uri.parse('$baseUrl/maintenance/get/maintenances/maintener'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        });

    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['maintenances'];
      getCurrentMaintenances(
          rss.map((e) => MaintenancesModel.fromJSON(e)).toList());
      return true;
    }
  }
  return false;
}

Future<bool> getMaintenancesByGobernante(int id) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(
        Uri.parse('$baseUrl/maintenance/get/maintenances/gobernante'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: jsonEncode({"id": id}));
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['maintenances'];
      getCurrentMaintenances(
          rss.map((e) => MaintenancesModel.fromJSON(e)).toList());
      return true;
    }
  }
  return false;
}

Future getCurrentMaintenances(List<MaintenancesModel> maintenances) async {
  // ignore: prefer_typing_uninitialized_variables
  var response;
  for (var i = 0; i < maintenances.length; i++) {
    if (maintenances[i].id != 0) {
      response = await getMaintenanceById(maintenances[i].id);
      maintenances[i].room_name =
          response['maintenances']['room_data']['name'] ?? '';
    }
  }
  currentMaintenances.value = maintenances;
}

Future getMaintenanceById(id) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();

    final response =
        await client.post(Uri.parse('$baseUrl/maintenance/get/maintenance'),
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

Future<bool> addMaintenance(Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.post(Uri.parse('$baseUrl/maintenance/register'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              "authorization": authorizationKey,
              "Cookie": 'access_token=$session',
            },
            body: json.encode(useBody));
    if (response.statusCode == 202) {
      getMaintenances();
      return true;
    }
  }
  return false;
}
