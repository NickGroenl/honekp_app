import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:cache_manager/cache_manager.dart';
import 'package:newhonekapp/app/models/shop.dart';
import 'constants.dart';

Future<bool> getShops() async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.get(Uri.parse('$baseUrl/shop/get'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Cookie": 'access_token=$session',
      "authorization": authorizationKey,
    });
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['data'];
      currentShops.value = rss.map((e) => ShopsModel.fromJSON(e)).toList();
      return true;
    }
  }
  return false;
}

Future<bool> addShop(Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(Uri.parse('$baseUrl/shop/add'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: json.encode(useBody));
    if (response.statusCode == 202) {
      return true;
    }
  }
  return false;
}

Future<bool> getShopsServices() async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.get(Uri.parse('$baseUrl/shop/services/get'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Cookie": 'access_token=$session',
      "authorization": authorizationKey,
    });
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['data'];
      currentShopsServices.value =
          rss.map((e) => ShopsModel.fromJSON(e)).toList();
      return true;
    }
  }
  return false;
}

Future<bool> addShopServices(Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(Uri.parse('$baseUrl/shop/services/add'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: json.encode(useBody));
    print(response.body);
    if (response.statusCode == 202) {
      return true;
    }
  }
  return false;
}
