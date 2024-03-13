import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:cache_manager/cache_manager.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/user/login.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import '../models/bookings/bookings.dart';
import 'constants.dart';
import 'package:dio/dio.dart';
final dio = Dio();

Future<bool> sendLogin(Object useBody) async {
  final client = http.Client();
  final response = await client.post(Uri.parse('$baseUrl/user/login'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authorization": authorizationKey,
      },
      body: json.encode(useBody));
  print(response);
  if (response.statusCode == 202) {
    await WriteCache.setString(
        key: 'session', value: json.decode(response.body)['token']);
    currentUser.value = UserModel.fromJSON(json.decode(response.body)['user']);
    return true;
  }
  return false;
}

Future<bool> getUser(bool isHome) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.get(Uri.parse('$baseUrl/user/data'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      "Cookie": 'access_token=$session',
      "authorization": authorizationKey,
    });
    if (response.statusCode == 202) {
      if (json.decode(response.body) == null) {
        DeleteCache.deleteKey('session');
        return false;
      } else {
        currentUser.value = UserModel.fromJSON(
            json.decode(response.body) != null
                ? json.decode(response.body)['user']
                : '');
      }
      return true;
    }
  }
  return false;
}

Future<bool> updateAddress(Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(
      Uri.parse('$baseUrl/user/update/direction'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        "Cookie": 'access_token=$session',
        "authorization": authorizationKey,
      },
      body: json.encode(useBody),
    );
    if (response.statusCode == 202) {
      getUser(false);
      return true;
    }
  }
  return false;
}

Future<bool> updateBilling(context, Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(
      Uri.parse('$baseUrl/user/update/billing'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        "Cookie": 'access_token=$session',
        "authorization": authorizationKey,
      },
      body: json.encode(useBody),
    );
    print(response.body);
    if (response.statusCode == 202) {
      getUser(false);
      Helper.nextScreen(context, Dashboard());
      return true;
    }
  }
  return false;
}

Future<bool> updateProfile(Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    http.Response response = await client.post(
      Uri.parse('$baseUrl/user/update/profile'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        "Cookie": 'access_token=$session',
        "authorization": authorizationKey,
      },
      body: json.encode(useBody),
    );
    print(response.body);
    if (response.statusCode == 202) {
      getUser(false);
      return true;
    }
  }
  return false;
}

Future<bool> scanToDataBase(dynamic useBody) async {
  try {
    var session = await ReadCache.getString(key: 'session') ?? '';
    if (session != '') {
      final client = http.Client();
      print(session);
      http.Response response = await client.post(
        Uri.parse('$baseUrl/user/update/scan'),
        headers:{
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',

          "Cookie": 'access_token=$session',
          "authorization": authorizationKey,
        },
        body: json.encode(useBody),
      );
      print(response.body);
      if (response.statusCode == 202) {
        return true;
      }
    }
  } catch (e) {
    print(e);
    return false;
  }
  return false;
}

Future scanReadyDates(Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(
      Uri.parse('$baseUrl/user/update/dates'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        "Cookie": 'access_token=$session',
        "authorization": authorizationKey,
      },
      body: json.encode(useBody),
    );
    if (response.statusCode == 202) {
      return true;
    }
  }
  return false;
}

Future<bool> resetPassword(Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';

  final client = http.Client();
  final response = await client.post(
    Uri.parse('$baseUrl/user/resetpassword'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      "Cookie": 'access_token=$session',
      "authorization": authorizationKey,
    },
    body: json.encode(useBody),
  );
  print(response.body);
  if (response.statusCode == 202) {
    return true;
  }

  return false;
}

Future updatePassword(Object useBody, context) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(
      Uri.parse('$baseUrl/user/update/password'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        "Cookie": 'access_token=$session',
        "authorization": authorizationKey,
      },
      body: json.encode(useBody),
    );
    if (response.statusCode == 202) {
      DeleteCache.deleteKey('session');
      Helper.nextScreen(context, Login());
      if (currentBooking.value.isNotEmpty) {
        for (var i = 0; i < currentBooking.value.length; i++) {
          currentBooking.value.removeAt(i);
        }
      }
      if (currentAllBookings.value.isNotEmpty) {
        for (var i = 0; i < currentAllBookings.value.length; i++) {
          currentAllBookings.value.removeAt(i);
        }
      }
      return true;
    }
  }
  return false;
}

Future updateMarketing(Object useBody) async {
  var session = await ReadCache.getString(key: 'session');
  final String apiToken = 'Bearer $session';
  final client = http.Client();
  final response = await client.put(
    Uri.parse('$baseUrl/v1/module/network/update/${currentUser.value.id}'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: apiToken,
    },
    body: json.encode(useBody),
  );
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
