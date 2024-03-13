// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class BookingAdministratorCard extends StatefulWidget {
  final String room_name;
  final String user_name;
  final bool house_keeping;
  final String date_end;
  final int nights;
  final int guests;
  

  const BookingAdministratorCard(
      {super.key,
      required this.room_name,
      required this.user_name,
      required this.house_keeping,
      required this.date_end, required this.nights, required this.guests});

  @override
  // ignore: no_logic_in_create_state
  createState() => _BookingAdministratorCard();
}

class _BookingAdministratorCard extends State<BookingAdministratorCard> {
  @override
  void initState() {
    super.initState();
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
                                Row(
                                  children: [
                                    Text(
                                      widget.user_name,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromARGB(255, 55, 77, 144),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      widget.room_name,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(33, 45, 82, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.date_end,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(33, 45, 82, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          widget.house_keeping ? 'NO' : 'SI',
                                          style: GoogleFonts.roboto(
                                            fontSize: 20.0,
                                            color: widget.house_keeping
                                                ? Color.fromARGB(
                                                    255, 216, 77, 77)
                                                : Color.fromARGB(
                                                    255, 50, 123, 53),
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Ionicons.hand_right),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Ionicons.people_outline),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.guests.toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 20.0,
                                            color:  Color.fromARGB(255, 71, 73, 134),
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        
                                        
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        
                                        Text(
                                          widget.nights.toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 20.0,
                                            color:  Color.fromARGB(255, 71, 73, 134),
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Ionicons.moon_outline),
                                        
                                        
                                        
                                      ],
                                    )
                                  ],
                                ),
                              ]))),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            )));
  }
}
