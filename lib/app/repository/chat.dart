// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:cache_manager/cache_manager.dart';
import 'package:newhonekapp/app/models/chat.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:http/http.dart' as http;

Future<bool> getAllChats() async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();
    final response =
        await client.get(Uri.parse('$baseUrl/chats/data'), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      "authorization": authorizationKey,
      "Cookie": 'access_token=$session',
    });
    if (response.statusCode == 202) {
      List<dynamic> rss = json.decode(response.body)['messages'];
      getMessagesChat(rss.map((e) => ChatModel.fromJSON(e)).toList());
      return true;
    }
  }
  return false;
}

Future getMessagesChat(List<ChatModel> chats) async {
  // ignore: prefer_typing_uninitialized_variables
  var response;
  for (var i = 0; i < chats.length; i++) {
    response = await getChatMessagesById(chats[i].toId);
    if (response != null) {
      List rsss = response['messages'];
      chats[i].messages = rsss.map((e) => MessagesModel.fromJSON(e)).toList();
      chats[i].fullname = response['name'] ?? '';
      chats[i].image = response['image'] != null
          ? "$baseUrl/${response['image']}"
          : 'https://pds.honek.it/assets_new/img/honek_logo_small.jpeg';
    }
  }
  currentChats.value = chats;
  currentAllChats.value = chats;
}

Future<dynamic> getChatMessagesById(id) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();

    final response = await client.post(Uri.parse('$baseUrl/chats/messages'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          "authorization": authorizationKey,
          "Cookie": 'access_token=$session',
        },
        body: jsonEncode({"to_id": id}));
    if (response.statusCode == 202) {
      return json.decode(response.body);
    }
  }
  return null;
}

Future addMessage(Object useBody) async {
  var session = await ReadCache.getString(key: 'session') ?? '';
  if (session != '') {
    final client = http.Client();

    final response = await client.post(Uri.parse('$baseUrl/chats/add'),
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
  return false;
}
