import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/chat.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/chat.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';

import '../../../ui-kit/widgets/cards/chat_card.dart';
import '../user/user_configuration.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  createState() => _ChatList();
}

class _ChatList extends State<ChatList> {
  final translator = GoogleTranslator();
  String searchChat = 'Cerca o inizia nuova chat';

  getTransalations(String lang) async {
    var searchChatCast =
        await translator.translate(searchChat, from: 'it', to: lang);

    setState(() {
      searchChat = searchChatCast.text;
    });

    return false;
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'searcher': FormControl<String>(
          validators: [Validators.email],
        ),
      });

  void filterChats(String text) {
    List<ChatModel> moments = [];
    for (var chatsDetail in currentChats.value) {
      if (chatsDetail.fullname.toLowerCase().contains(text.toLowerCase())) {
        moments.add(chatsDetail);
      }
    }
    if (moments.isEmpty || text.isEmpty) {
      moments = currentAllChats.value;
    }
    currentChats.value = moments;
  }

  Future<void> loadChats() async {
    await getAllChats();
  }

  @override
  void initState() {
    super.initState();
    print(currentUser.value.default_language);
    getTransalations(currentUser.value.default_language);
    loadChats();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
        form: buildForm,
        builder: (BuildContext context, FormGroup formGroup, Widget? child) {
          return ValueListenableBuilder(
              valueListenable: currentChats,
              builder: (BuildContext context, value, Widget? child) {
                return Scaffold(
                  bottomNavigationBar:
                      AppBottomNavigation(pageActually: "chat"),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SafeArea(child: SizedBox()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BackButton(),
                              Text(
                                "Chat",
                                style: GoogleFonts.roboto(
                                  fontSize: 20.0,
                                  height: 1.5,
                                  color: Color.fromARGB(255, 71, 80, 106),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                  onTap: () => Helper.nextScreen(
                                      context, UserConfiguration()),
                                  child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(currentUser
                                                        .value.image !=
                                                    ''
                                                ? "$baseUrl/${currentUser.value.image}"
                                                : ''),
                                            fit: BoxFit.cover),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12
                                                  .withOpacity(0.1),
                                              blurRadius: 10.0,
                                              spreadRadius: 2.0)
                                        ]),
                                  )),
                            ],
                          ),
                        ),
                        
                        SizedBox(
                          height: 15.0,
                        ),
                        Column(children: [
                          for (var item in currentChats.value)
                            ChatCardList(
                                card: ChatListModel(
                                    title: item.fullname,
                                    description: item.messages.isNotEmpty
                                        ? item
                                            .messages[item.messages.length - 1]
                                            .body
                                        : '',
                                    imagepath: item.image,
                                    time: item.messages.isNotEmpty
                                        ? item
                                            .messages[item.messages.length - 1]
                                            .time
                                        : '',
                                    chatAll: item)),
                        ]),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
