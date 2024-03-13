import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:cache_manager/cache_manager.dart';
import 'package:newhonekapp/app/models/maintenance.dart';
import 'package:newhonekapp/app/models/services.model.dart';
import 'constants.dart';

Future<bool> getServices(Object body) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(Uri.parse('$baseUrl/services/get'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: jsonEncode(body));
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['data'];
      List<ServicesModel> castServices = [];
      List<ServicesModel> castServicesTwo = [];
      currentServices.value =
          rss.map((e) => ServicesModel.fromJSON(e)).toList();
      for (var item in currentServices.value) {
        if (item.type == 'selling') {
          if(item.priority == 'yes') {
            castServices.add(item);
          }
        } else {
          if(item.priority == 'yes') {
            castServicesTwo.add(item);
          }
        }
      }
      currentServicesPriority.value = castServices;
      currentServicesNoPay.value = castServicesTwo;

      return true;
    }
  }
  return false;
}
