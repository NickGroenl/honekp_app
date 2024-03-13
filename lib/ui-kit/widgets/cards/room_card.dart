// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/repository/bookings.dart';

import 'package:swipeable_button_view/swipeable_button_view.dart';
import '../../utils/constants.dart';

class RoomCard extends StatefulWidget {
  final String ip;
  final String name;

  const RoomCard({super.key, required this.ip, required this.name});

  @override
  // ignore: no_logic_in_create_state
  createState() => _RoomCard();
}

class _RoomCard extends State<RoomCard> {
  bool isFinished = false;
  String buttonText = 'Apri Camera';

  bool isAvailable = true;
  bool isCheckin = true;
  @override
  void initState() {
    super.initState();
    widget.ip == '' ? isAvailable = false : isAvailable = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Color(0xFFF4F5F6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                   
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                                      widget.name,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(33, 45, 82, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          SizedBox(
                            height: 5.0,
                          ),]))),
                          
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    child: SwipeableButtonView(
                        buttonText: buttonText,
                        buttontextstyle: GoogleFonts.roboto(
                            fontSize: 20, color: Colors.white),
                        buttonWidget: Icon(
                          Ionicons.lock_open_outline,
                          color: Colors.grey,
                        ),
                        activeColor: Constants.primaryColor,
                        onWaitingProcess: () async {
                          Future.delayed(Duration(seconds: 0), () async {
                            await apriCamera(widget.ip);
                            if (mounted) {
                              setState(() {
                                isFinished = true;
                              });
                            }
                          });
                        },
                        isActive: isAvailable,
                        isFinished: isFinished,
                        onFinish: () {
                          if (mounted) {
                            var countdown = 15;
                            Timer.periodic(Duration(seconds: 1), (timer) {
                              countdown--;
                              setState(() {
                                buttonText = countdown.toString();
                              });

                              if (countdown == 0) {
                                setState(() {
                                  isAvailable = true;
                                  buttonText = 'Apri Camera';
                                });
                                timer.cancel();
                              }
                            });
                            setState(() {
                              isFinished = false;
                              buttonText = 'Aspetta 10 secondi';
                              isAvailable = false;
                            });
                          }
                        }),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            )));
  }
}
