import 'package:flutter/cupertino.dart';

ValueNotifier<List<MemberModell>> currentMembers =
    ValueNotifier(<MemberModell>[]);

class MemberModell {
  String mobile = '';
  int id = 0;
  String name = '';
  String lastname = '';
  String email = '';
  String direction = '';
  String image = '';

  MemberModell.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] ?? 0;
      name = jsonMap['name'] ?? '';
      lastname = jsonMap['lastname'] ?? '';
      email = jsonMap['email'] ?? '';
      direction = jsonMap['address'] ?? '';
      mobile = jsonMap['mobile'] ?? '';
      image = jsonMap['image'] ?? '';
    } catch (e) {
      id = 0;
      name = '';
      email = '';
      lastname = '';
      direction = '';
      image = '';
    }
  }
}
