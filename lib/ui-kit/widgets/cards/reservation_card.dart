// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/bookings.dart';
import 'package:newhonekapp/app/routes/bookings/allCheckin.dart';
import 'package:newhonekapp/app/routes/bookings/bookings_view.dart';
import 'package:newhonekapp/ui-kit/models/reservation_item.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:translator/translator.dart';
import '../../utils/constants.dart';

class ReservationCard extends StatefulWidget {
  final ReservationModel reservationdata;

  const ReservationCard({super.key, required this.reservationdata});

  @override
  // ignore: no_logic_in_create_state
  createState() => _ReservationCard();
}

class _ReservationCard extends State<ReservationCard> {
  bool isFinished = false;
  String buttonText = 'Apri Camera';

  bool isAvailable = true;
  bool isCheckin = true;
  final translator = GoogleTranslator();
  String open = 'Apri Camera';
  String awaitt = 'Aspetta 10 secondi';
  String days = "Giorni rimanenti: ";
  String from = "dal";

  getTransalations(String lang) async {
    var openCast = await translator.translate(open, from: 'it', to: lang);
    var awaitCast = await translator.translate(awaitt, from: 'it', to: lang);
    var daysCast = await translator.translate(days, from: 'it', to: lang);
    var fromCast = await translator.translate(from, from: 'it', to: lang);
    setState(() {
      open = openCast.text;
      awaitt = awaitCast.text;
      days = daysCast.text;
      from = fromCast.text;
    });

    return false;
  }

  @override
  void initState() {
    super.initState();
    isAvailable = widget.reservationdata.ipcamera == '' ? false : true;

    if (widget.reservationdata.members != null) {
      for (var i = 0; i < widget.reservationdata.members.length; i++) {
        if (widget.reservationdata.members[i].image.length < 7) {
          isAvailable = false;
          isCheckin = false;
          break;
        }
      }
    }

    if (widget.reservationdata.archivate) {
      if (currentAllBookings.value.isNotEmpty) {
        if (currentAllBookings
                .value[widget.reservationdata.index].checkin_hour ==
            '') {
          isCheckin = false;
        }
      }
    } else {
      if (currentAllBookings.value.isNotEmpty) {
        if (currentBooking.value[widget.reservationdata.index].checkin_hour ==
            '') {
          isCheckin = false;
        }
      }
    }
    getTransalations(currentUser.value.default_language != '' ? currentUser.value.default_language : 'en');
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
                    onTap: () => {
                      widget.reservationdata.archivate
                          ? ''
                          : (isCheckin
                              ? Helper.nextScreen(
                                  context,
                                  BookingView(
                                      bookingIndex:
                                          widget.reservationdata.index))
                              : Helper.nextScreen(
                                  context,
                                  CheckinAll(
                                      id: widget.reservationdata.id,
                                      members: widget.reservationdata.members,
                                      index: widget.reservationdata.index,
                                      status:
                                          widget.reservationdata.checkinstate)))
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 0,
                                child: Column(
                                  children: <Widget>[
                                     Text(
                                      widget.reservationdata.title,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(33, 45, 82, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Expanded(
                                flex: 0,
                                child: Column(
                                  children: <Widget>[
                                    (isCheckin == false) &&
                                            (!widget.reservationdata.archivate)
                                        ? Text(
                                            "Check-in",
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Colors.redAccent),
                                          )
                                        : Text("")
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '$from ${widget.reservationdata.date}',
                            style: GoogleFonts.roboto(
                              fontSize: 15.0,
                              color: Color.fromRGBO(138, 150, 190, 1),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "$days ${int.parse(widget.reservationdata.nights) > 0 ? widget.reservationdata.nights : 0} \n",
                                      style: GoogleFonts.roboto(
                                          color: Color.fromRGBO(64, 74, 106, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0),
                                    ),
                                    TextSpan(
                                      text:
                                          "€${widget.reservationdata.price} \n",
                                      style: GoogleFonts.roboto(
                                        color: Color.fromARGB(255, 21, 139, 62),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    TextSpan(
                                      // ignore: prefer_if_null_operators
                                      text: widget.reservationdata.email == null
                                          ? null
                                          : widget.reservationdata.email,
                                      style: GoogleFonts.roboto(
                                        color: Color.fromARGB(255, 49, 51, 50),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  widget.reservationdata.archivate
                      ? SizedBox(
                          height: 0.0,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: SwipeableButtonView(
                              buttonText: open,
                              buttontextstyle: GoogleFonts.roboto(
                                  fontSize: 20, color: Colors.white),
                              buttonWidget: Icon(
                                Ionicons.lock_open_outline,
                                color: Colors.grey,
                              ),
                              buttonColor: Color.fromRGBO(26, 92, 166, 1),
                              activeColor: Color.fromRGBO(26, 92, 166, 1),
                              onWaitingProcess: () async {
                                Future.delayed(Duration(seconds: 0), () async {
                                  await apriCamera(
                                      widget.reservationdata.ipcamera);
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
                                        buttonText = open;
                                      });
                                      timer.cancel();
                                    }
                                  });
                                  setState(() {
                                    isFinished = false;
                                    buttonText = awaitt;
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
