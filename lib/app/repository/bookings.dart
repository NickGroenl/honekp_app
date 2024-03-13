// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cache_manager/cache_manager.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/bookings/members.dart';
import 'package:newhonekapp/app/repository/foodandbeverage.dart';
import 'package:newhonekapp/app/repository/services.dart';
import 'constants.dart';

Future<bool> getAllBookings() async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.get(Uri.parse('$baseUrl/bookings/data'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      "authorization": authorizationKey,
      "Cookie": 'access_token=$session',
    });

    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['bookings'];
      getCurrentBookings(rss.map((e) => BookingModel.fromJSON(e)).toList());
      return true;
    }
  }
  return false;
}

Future<bool> getAllBookingsAdministrator(Object body) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(Uri.parse('$baseUrl/bookings/dataall'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: json.encode(body));
    print(response.body);
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['bookings'];
      getCurrentBookingsAdministrator(
          rss.map((e) => BookingModel.fromJSON(e)).toList());
      return true;
    }
  }
  return false;
}

Future getCurrentBookingsAdministrator(List<BookingModel> bookings) async {
  late List<BookingModel> now = [];
  late List<BookingModel> old = [];
  late List<BookingModel> current = [];
  late DateTime currentTime = DateTime.now();
  final String formattedCurrentTime =
      "${currentTime.day}-${currentTime.month}-${currentTime.year}";

  late DateTime castTime = DateTime.now();
  late String formattedCastTime;

  late DateTime castEndTime = DateTime.now();
  late String formattedEndCastTime;
  // ignore: prefer_typing_uninitialized_variables
  var response;
  for (var i = 0; i < bookings.length; i++) {
    print(bookings[i].id);
    if (bookings[i].endDate != '') {
      response = await getBookingById(bookings[i].id);
      if (response != null) {
        bookings[i].name_structure =
            response['booking']['name_structure'] ?? '';
        bookings[i].house_keeping =
            response['booking']['house_keeping'] ?? false;
        bookings[i].status = response['booking']['status'] ?? '';
        bookings[i].guests = response['booking']['guests'] ?? 0;

        List rsss = response['booking']['booking_members'];
        bookings[i].members =
            rsss.map((e) => MemberModell.fromJSON(e)).toList();
        bookings[i].bookingNumber = response['booking']['room_data'] == null
            ? ''
            : response['booking']['room_data']['name'] ?? '';
        castTime = DateTime.parse(bookings[i].startDate);
        formattedCastTime =
            "${castTime.day}-${castTime.month}-${castTime.year}";
        castEndTime = DateTime.parse(bookings[i].endDate);
        formattedEndCastTime =
            "${castEndTime.day}-${castEndTime.month}-${castEndTime.year}";
        bookings[i].night++;

        print(formattedEndCastTime);
        print(formattedCurrentTime);
        if (formattedCastTime == formattedCurrentTime) {
          now.add(bookings[i]);
        } else if (formattedEndCastTime == formattedCurrentTime) {
          old.add(bookings[i]);
        } else if (bookings[i].night >= 1) {
          current.add(bookings[i]);
        }
      }
    }
  }
  currentAdministratorBookings.value = current.map((e) => e).toList();
  oldedAdmninistratorBookings.value = old.map((e) => e).toList();
  newsAdministratorBookings.value = now.map((e) => e).toList();
}

Future getCurrentBookings(List<BookingModel> bookings) async {
  late List<BookingModel> rss = [];
  late List<BookingModel> rssArchiviate = [];
  // ignore: prefer_typing_uninitialized_variables
  var response;
  late String ips;
  for (var i = 0; i < bookings.length; i++) {
    if (bookings[i].endDate != '') {
      response = await getBookingById(bookings[i].id);
      if(response != null) {
        ips = response['booking']['room_data'] == null
          ? ''
          : response['booking']['room_data']['ip_address'] ?? '';
          bookings[i].ip = ips.toString();
      bookings[i].name_structure = response['booking']['name_structure'] ?? '';
      bookings[i].namber_room = response['booking']['booking_number'] ?? '';
      bookings[i].bookingNumber = response['booking']['room_data'] == null
          ? ''
          : response['booking']['room_data']['name'] ?? '';
      bookings[i].id_room = (response['booking']['room_data'] == null
          ? 0
          : response['booking']['room_data']['id'] ?? 0);
      bookings[i].author_id =
          response['booking']['booking_members'][0]['id'] ?? '';
      bookings[i].guests = response['booking']['guests'] ?? 0;
      bookings[i].author_id = response['booking']['author_id'] ?? 0;
      bookings[i].key_public = response['booking']['key_public'] ?? '';
      bookings[i].key_secret = response['booking']['key_secret'] ?? '';
      bookings[i].checkin_hour = response['booking']['checkin_hour'] ?? '';
      List rsss = response['booking']['booking_members'];
      bookings[i].members = rsss.map((e) => MemberModell.fromJSON(e)).toList();
      if (bookings[i].night > 0) {
        rss.add(bookings[i]);
        await checkRolesChats({
          "id": bookings[i].author_id,
          "name_structure": bookings[i].name_structure
        });
        await getServices({"author_id": bookings[i].author_id});
        await getFoods(
            bookings[i].name_structure, {"author_id": bookings[i].author_id});
        await getBeverages(
            bookings[i].name_structure, {"author_id": bookings[i].author_id});
      } else {
        rssArchiviate.add(bookings[i]);
      }
      }
      
    }
  }
  currentAllBookings.value = rssArchiviate.map((e) => e).toList();
  currentBooking.value = rss.map((e) => e).toList();
}

Future checkRolesChats(Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();

    final response = await client.post(Uri.parse('$baseUrl/chats/getRoles'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: jsonEncode(useBody));

    if (response.statusCode == 202) {
      return true;
    }
  }
  return true;
}

Future getBookingById(id) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();

    final response = await client.post(Uri.parse('$baseUrl/bookings/data'),
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

Future<bool> checkinBooking(Object body) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(
      Uri.parse('$baseUrl/bookings/checkin'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        "authorization": authorizationKey,
        "Cookie": 'access_token=$session',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 202) {
      return true;
    }
  }
  return false;
}

Future<bool> addMemberBooking(Object data) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response = await client.post(Uri.parse('$baseUrl/user/register'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: json.encode(data));
    if (response.statusCode == 202) {
      return true;
    }
  }
  return false;
}

Future<bool> apriCamera(String ip) async {
  if (ip != '') {
    final client = http.Client();
    final response = await client.post(Uri.parse('$ip/zeroconf/switch'),
        body: json.encode({
          "deviceid": "",
          "data": {"switch": "on"}
        }));
    if (response.statusCode == 200) {
      return true;
    }
  }
  return false;
}
