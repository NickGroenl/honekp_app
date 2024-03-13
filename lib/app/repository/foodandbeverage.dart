import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:cache_manager/cache_manager.dart';
import 'package:newhonekapp/app/models/foodandbeverage.dart';
import 'constants.dart';

Future getFoods(String nameStructure, Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();

    final response = await client.post(Uri.parse('$baseUrl/fandb/data/food'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: jsonEncode(useBody));
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['data'];
      currentFoods.value = [
        ...rss
            .map((e) => FoodAndBeverageModel.fromJSON(e, nameStructure))
            .toList()
      ];
    }
  }
}

Future getBeverages(String nameStructure, Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.post(Uri.parse('$baseUrl/fandb/data/beverage'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              "authorization": authorizationKey,
              "Cookie": 'access_token=$session',
            },
            body: jsonEncode(useBody));
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['data'];
      currentBeverages.value = [
        ...rss
            .map((e) => FoodAndBeverageModel.fromJSON(e, nameStructure))
            .toList()
      ];
    }
  }
}

