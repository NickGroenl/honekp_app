import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/maintenance.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:translator/translator.dart';

class MaintanceView extends StatefulWidget {
  final MaintenancesModel maintenance;
  const MaintanceView({super.key, required this.maintenance});
  @override
  createState() => _MaintanceView();
}

class _MaintanceView extends State<MaintanceView> {
  late String roomname = '';
  late String manutentorename = '';
  late String priority = '';

  final translator = GoogleTranslator();
  String low = 'Bassa';
  String medium = "Media";
  String long = "Alta";
  String urgently = "Urgente";

  getTranslations(String lang) async {
    var lowCast = await translator.translate(low, from: 'it', to: lang);
    var mediumCast = await translator.translate(medium, from: 'it', to: lang);
    var longCast = await translator.translate(long, from: 'it', to: lang);
    var urgentlyCast =
        await translator.translate(urgently, from: 'it', to: lang);
    
    setState(() {
      low = lowCast.text;
      medium = mediumCast.text;
      long = longCast.text;
      urgently = urgentlyCast.text;
      
    });

    return false;
  }

  @override
  void initState() {
    super.initState();
    getTranslations(currentUser.value.default_language);

    // ignore: use_build_context_synchronously

    for (var i = 0; i < currentAllBookings.value.length; i++) {
      if (widget.maintenance.room_id == currentAllBookings.value[i].id_room) {
        roomname = currentAllBookings.value[i].bookingNumber;
      }
    }
    for (var i = 0; i < currentBooking.value.length; i++) {
      if (widget.maintenance.room_id == currentBooking.value[i].id_room) {
        roomname = currentBooking.value[i].bookingNumber;
      }
    }
    for (var i = 0; i < currentMainteners.value.length; i++) {
      if (widget.maintenance.user_id == currentMainteners.value[i].id) {
        manutentorename =
            "${currentMainteners.value[i].name} ${currentMainteners.value[i].lastname}";
      }
    }
    switch (widget.maintenance.priority) {
      case 0:
        priority = low;
        break;
      case 1:
        priority = medium;
        break;
      case 2:
        priority = long;
        break;
      case 3:
        priority = urgently;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(bottom: false, child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  BackButton(),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color.fromARGB(0, 244, 245, 246),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.key_outline,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      roomname,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.man_outline,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      manutentorename,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.alert_circle_outline,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      priority,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.hand_left_outline,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        widget.maintenance.reason,
                                        style: GoogleFonts.roboto(
                                          fontSize: 20.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.clip,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.reader_outline,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                        width: 250,
                                        child: Text(
                                          widget.maintenance.notes,
                                          style: GoogleFonts.roboto(
                                            fontSize: 20.0,
                                            color: Color.fromRGBO(
                                                138, 150, 191, 1),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 3,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 25.0,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        widget.maintenance.status == 'request'
                                            ? Color.fromARGB(255, 173, 182, 10)
                                            : Color.fromARGB(255, 10, 119, 182),
                                  ),
                                  child: Text(
                                    widget.maintenance.status.toUpperCase(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 20.0,
                                      color: Color.fromARGB(255, 42, 44, 49),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
