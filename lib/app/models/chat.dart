import 'package:flutter/material.dart';
import 'package:newhonekapp/app/models/user.dart';

ValueNotifier<List<ChatModel>> currentChats = ValueNotifier(<ChatModel>[]);
ValueNotifier<List<ChatModel>> currentAllChats = ValueNotifier(<ChatModel>[]);

class ChatListModel {
  final String title;
  final String time;
  final String imagepath;
  final String description;
  final ChatModel chatAll;

  ChatListModel(
      {required this.title,
      required this.time,
      required this.imagepath,
      required this.description,
      required this.chatAll});
}

class ChatModel {
  late int toId = 0;
  late String fullname = '';
  late String image = '';
  late List<MessagesModel> messages = [];

  ChatModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      toId = jsonMap['to_id'] == currentUser.value.id ? jsonMap['from_id'] : jsonMap['to_id'];
    } catch (e) {
      toId = 0;
    }
  }
}

class MessagesModel {
  late String body;
  late String time;
  late int toId;
  late int fromId;
  late String image;
  late int seen;

  MessagesModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      fromId = jsonMap['from_id'] ?? 0;
      body = jsonMap['body'] ?? '';
      toId = jsonMap['to_id'] ?? 0;
      time = jsonMap['created_at'] ?? '';
      seen = jsonMap['seen'] ?? 0;
    } catch (e) {
      fromId = 0;
      body = '';
      toId = 0;
    }
  }
}
