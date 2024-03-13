import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/chat.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/app/routes/chat/chat_message.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:http/http.dart' as http;

class ChatCardList extends StatefulWidget {
  final ChatListModel card;
  const ChatCardList({super.key, required this.card});

  @override
  createState() => _ChatCardList();
}

class _ChatCardList extends State<ChatCardList> {
  late bool siono = false;
  @override
  void initState() {
    super.initState();

    () async {
      if (widget.card.imagepath != '') {
        final response = await http.get(Uri.parse(widget.card.imagepath));
        if (response.statusCode == 200) {
          if (mounted) {
            setState(() {
              siono = true;
            });
          }
        }
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Color.fromARGB(0, 255, 255, 255),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: () => Helper.nextScreen(
                        context, ChatPage(chatItem: widget.card.chatAll)),
                    child: Card(
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 35, // Image radius
                                backgroundImage: NetworkImage(
                                    siono ? widget.card.imagepath : ''),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        widget.card.title,
                                        style: GoogleFonts.roboto(
                                          fontSize: 17.0,
                                          color: Color.fromRGBO(33, 45, 82, 1),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        widget.card.description,
                                        style: GoogleFonts.roboto(
                                          fontSize: 15.0,
                                          color:
                                              Color.fromARGB(255, 92, 93, 95),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                          child: Row(children: [
                                            Text(
                                              widget.card.time,
                                              style: GoogleFonts.roboto(
                                                fontSize: 13.0,
                                                height: 1.5,
                                                color: Color.fromARGB(
                                                    255, 130, 131, 130),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Ionicons.chevron_forward_outline,
                                              size: 22,
                                              color: Constants.primaryColor,
                                            )
                                          ])),
                                      SizedBox(
                                        height: 1.0,
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
