// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:newhonekapp/app/models/chat.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/chat.dart';
import 'package:newhonekapp/app/routes/chat/chats.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chatItem;
  const ChatPage({super.key, required this.chatItem});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late List<MessagesModel> messages = widget.chatItem.messages;
  final translator = GoogleTranslator();
  String writeMessage = "Scrivi un messaggio";
  String writeMessageInput = 'Devi inserire un messaggio';

  getTransalations(String lang) async {
    var writeMessageCast =
        await translator.translate(writeMessage, from: 'it', to: lang);
    var writeMessageInputCast =
        await translator.translate(writeMessageInput, from: 'it', to: lang);

    setState(() {
      writeMessage = writeMessageCast.text;
      writeMessageInput = writeMessageInputCast.text;
    });

    return false;
  }

  @override
  void initState() {
    super.initState();
    getTransalations(currentUser.value.default_language);
    Timer.periodic(Duration(milliseconds: 2500), (timer) async {
      if (mounted) {
        var response = await getChatMessagesById(widget.chatItem.toId);
        if (response != null) {
          List rsss = response['messages'] ?? [];
          if (rsss.isNotEmpty) {
            setState(() {
              messages = rsss.map((e) => MessagesModel.fromJSON(e)).toList();
            });

            if (currentChats.value.contains(widget.chatItem) &&
                (currentChats.value.indexOf(widget.chatItem) <=
                    currentChats.value.length)) {
              currentChats.value[currentChats.value.indexOf(widget.chatItem)]
                      .messages =
                  rsss.map((e) => MessagesModel.fromJSON(e)).toList();
            } else {
              if (timer.isActive) {
                timer.cancel();
              }
              return;
            }
          }
        }
      } else {
        if (timer.isActive) {
          timer.cancel();
        }
        return;
      }
    });
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'message': FormControl<String>(
          validators: [Validators.required, Validators.minLength(1)],
        ),
      });

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chatItem.fullname,
          style: GoogleFonts.roboto(),
        ),
        leading: BackButton(
          onPressed: (() async {
            await getAllChats();
            // ignore: use_build_context_synchronously
            Helper.nextScreen(context, ChatList());
          }),
        ),
        backgroundColor: Constants.buttonColor,
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 220, 216, 216),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0)),
          ),
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
          child: ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  // First child is enter comment text input
                  Expanded(
                    child: ReactiveTextField<String>(
                      formControlName: 'message',
                      validationMessages: {
                        ValidationMessage.required: (_) => writeMessageInput,
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: writeMessage,
                        helperText: '',
                        helperStyle: TextStyle(height: 0.7),
                        errorStyle: TextStyle(height: 0.7),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 220, 216, 216),
                        shadowColor: Colors.transparent,
                        disabledBackgroundColor:
                            Color.fromARGB(255, 220, 216, 216)),
                    child: Icon(
                      Icons.send,
                      color: Constants.primaryColor,
                    ),
                    onPressed: () async {
                      if (form.valid) {
                        await addMessage({
                          "body": form.value['message'],
                          "to_id": widget.chatItem.toId
                        });
                      } else {
                        form.markAllAsTouched();
                      }
                    },
                  ),
                ]);
              })),
      body: ValueListenableBuilder(
        builder: (BuildContext context, value, Widget? child) {
          return SingleChildScrollView(
            reverse: true,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
              child: Column(children: [
                for (var item in messages)
                  SizedBox(
                    child: item.fromId == currentUser.value.id
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.bottomRight,
                            child: Row(children: [
                              Spacer(),
                              IntrinsicWidth(
                                  child: Container(
                                constraints: BoxConstraints(maxWidth: 250),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(232, 254, 216, 100),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)),
                                ),
                                child: Text(item.body),
                              ))
                            ]),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.bottomLeft,
                            child: Row(children: [
                              IntrinsicWidth(
                                  child: Container(
                                constraints: BoxConstraints(maxWidth: 250),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 218, 218, 218),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)),
                                ),
                                child: Text(item.body),
                              )),
                            ]),
                          ),
                  )
              ]),
            ),
          );
        },
        valueListenable: currentChats,
      ));
}
//IntrinsicWidth