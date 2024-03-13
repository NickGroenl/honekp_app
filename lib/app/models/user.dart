// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';

enum UserState { available, away, busy }

ValueNotifier<UserModel> currentUser = ValueNotifier(UserModel());
ValueNotifier<List<String>> currentCountries = ValueNotifier(<String>[]);

class UserModel {
  late int id = 0;
  late String name = '';
  late String lastname = '';
  late String email = '';
  late String birth = '';
  late int country_id = 0;
  late int province_id = 0;
  late int city_id = 0;
  late String zip = '';
  late String gender = '';
  late String default_language = '';
  late String currency = '';
  late String time_zone = '';
  late String format_date = '';
  late bool marketing_mail = false;
  late bool marketing_sms = false;
  late bool marketing_newsletter = false;
  late String mobile = '';
  late bool verifiedPhone = false;
  late String verificationId = '';
  late String address = '';
  late String image = '';
  late String name_bill = '';
  late String vat = '';
  late String fiscal_code = '';
  late String city_bill = '';
  late String address_bill = '';
  late String province_bill = '';
  late String zip_bill = '';
  late String certified_mail = '';
  late String sdi_code = '';
  late String back_image = '';
  late String front_image = '';
  late String placebirth = '';
  late String number_document = '';
  late int parentId = 0;
  late int authorid = 0;
  late List<RolesModel> roles = [];
  late String pec = '';
  late String zip_code = '';
  late String citta = '';
  late String nazione = '';
//  String role;

  UserModel();

  UserModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] ?? 0;
      List<dynamic> rss = jsonMap['roles'] ?? [];
      roles = [...rss.map((e) => RolesModel.fromJSON(e))];
      parentId = jsonMap['parent_id'] ?? 0;
      name_bill = jsonMap['name_bill'] ?? '';
      vat = jsonMap['vat'] ?? '';
      fiscal_code = jsonMap['fiscal_code'] ?? '';
      city_bill = jsonMap['city_bill'] ?? '';
      address_bill = jsonMap['address_bill'] ?? '';
      province_bill = jsonMap['province_bill'] ?? '';
      currency = jsonMap['currency'] ?? '';
      time_zone = jsonMap['time_zone'] ?? '';
      format_date = jsonMap['format_date'] ?? '';
      zip_bill = jsonMap['zip_bill'] ?? '';
      certified_mail = jsonMap['certified_mail'] ?? '';
      sdi_code = jsonMap['sdi_code'] ?? '';
      marketing_mail = (jsonMap['marketing_communication'] != null &&
              jsonMap['marketing_communication'].contains('mail'))
          ? true
          : false;
      marketing_sms = (jsonMap['marketing_communication'] != null &&
              jsonMap['marketing_communication'].contains('sms'))
          ? true
          : false;
      marketing_newsletter = (jsonMap['marketing_communication'] != null &&
              jsonMap['marketing_communication'].contains('newsletter'))
          ? true
          : false;
      name = jsonMap['name'] ?? '';
      birth = jsonMap['birth'] ?? '';
      gender = jsonMap['gender'] ?? '';
      default_language = jsonMap['language'] ?? 'it';
      lastname = jsonMap['lastname'] ?? '';
      email = jsonMap['email'] ?? '';
      zip = jsonMap['zip'] ?? '';
      zip_code = jsonMap['zip_code'] ?? '';
      country_id = jsonMap['country_id'] ?? 0;
      province_id = jsonMap['province_id'] ?? 0;

      city_id = jsonMap['city_id'] ?? 0;
      mobile = jsonMap['phone'] ?? '';
      address = jsonMap['address'] ?? '';
      authorid = jsonMap['user_status_id'] ?? '';
      image = jsonMap['image'] ?? '';
      back_image = jsonMap['back_image'] ?? '';
      front_image = jsonMap['front_image'] ?? '';
      placebirth = jsonMap['placebirth'] ?? '';
      number_document = jsonMap['number_document'] ?? '';
      citta = jsonMap['citta'] ?? '';
      nazione = jsonMap['nazione'] ?? '';

      // FATTURAZIONE
      pec = jsonMap['pec'] ?? '';
      // ignore: empty_catches
    } catch (value) {}
  }
}

class RolesModel {
  late int role_id = 0;
//  String role;

  RolesModel();

  RolesModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      role_id = jsonMap['role_id'] ?? 0;

      // ignore: empty_catches
    } catch (value) {}
  }
}
