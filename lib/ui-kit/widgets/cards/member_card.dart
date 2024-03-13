// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/ui-kit/models/members.dart';


class MemberCard extends StatelessWidget {
  final MemberModel memberData;
  
  const MemberCard({super.key, required this.memberData});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0
        ),
        child: Container(
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Color.fromARGB(255, 244, 245, 246),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(  
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          memberData.name,
                          style: GoogleFonts.roboto(
                            fontSize: 24.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 42, 61, 116),
                            fontWeight: FontWeight.w600,
                          ),
                          
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        

                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.home_outline),
                                ),
                              ),
                              TextSpan(
                                style: TextStyle(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Indirizzo: ${memberData.direction}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        
                        RichText(
                          
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.phone_portrait_outline),
                                ),
                              ),
                              TextSpan(
                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Cellulare: ${memberData.phone}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.mail_outline),
                                ),
                              ),
                              TextSpan(
                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Email: ${memberData.email}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.radio_button_off_outline),
                                ),
                              ),
                              TextSpan(
                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Stato: ${memberData.status}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.calendar_number_outline),
                                ),
                              ),
                              TextSpan(
                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Dal: ${memberData.startDate} Al: ${memberData.endDate}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.hand_left_outline),
                                ),
                              ),
                              TextSpan(
                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Ospiti: ${ memberData.member}, Bambini: ${memberData.childrens}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.pricetag_outline),
                                ),
                              ),
                              TextSpan(
                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Numero di prenotazione: ${memberData.roomID}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),


                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.information_circle_outline),
                                ),
                              ),
                              TextSpan(
                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Richieste Speciali: ${memberData.special}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.document_outline),
                                ),
                              ),
                              TextSpan(
                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Note: ${memberData.note}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        RichText(
                          text: TextSpan(
                            children: [
                              
                              WidgetSpan(
                                style: GoogleFonts.roboto(fontSize: 16),
                                child: Padding(
                                  
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.time_outline),
                                ),
                              ),
                              TextSpan(
                                style: GoogleFonts.roboto(color: Color.fromARGB(255, 58, 58, 58)),
                                text: "Orario di check-in: ${memberData.chekinDate}",
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    )
                  )
                  
            ],
          ),
        ),
      )
     
    );
  }
  
  
}