// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:newhonekapp/app/models/bookings/members.dart';

ValueNotifier<List<BookingModel>> currentBooking =
    ValueNotifier(<BookingModel>[]);
ValueNotifier<List<BookingModel>> currentAllBookings =
    ValueNotifier(<BookingModel>[]);

ValueNotifier<List<BookingModel>> currentAdministratorBookings =
    ValueNotifier(<BookingModel>[]);
ValueNotifier<List<BookingModel>> oldedAdmninistratorBookings =
    ValueNotifier(<BookingModel>[]);
ValueNotifier<List<BookingModel>> newsAdministratorBookings =
    ValueNotifier(<BookingModel>[]);

class BookingModel {
  String name_structure = '';
  int price = 0;
  int night = 0;
  String startDate = '';
  String endDate = '';
  String bookingNumber = '';
  String status = '';
  int id = 0;
  bool is_checkin_done = false;
  dynamic ip_check = '';
  String checkin_hour = '';
  String ip = '';
  int author_id = 0;
  int user_id = 0;
  int guests = 0;
  String namber_room = '';
  int id_room = 0;
  List<MemberModell> members = [];
  bool house_keeping = false;
  String key_public = '';
  String key_secret = '';
  BookingModel();

  BookingModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      price = jsonMap['price'] ?? '';
      night = jsonMap['nights'] ?? '';
      startDate = jsonMap['date_start'] ?? '';
      endDate = jsonMap['date_end'] ?? '';
      bookingNumber = jsonMap['booking_number'] ?? '';
      status = jsonMap['status'] ?? '';
      user_id = jsonMap['user_id'] ?? 0;
    } catch (e) {
      id = 0;
      name_structure = '';
      ip_check = false;
      is_checkin_done = false;
      price = 0;
      night = 0;
      startDate = '';
      endDate = '';
      bookingNumber = '';
      status = '';
    }
  }
}
