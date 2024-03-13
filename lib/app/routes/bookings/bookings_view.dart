import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/bookings/members.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/routes/bookings/add_member_email.dart';
import 'package:newhonekapp/ui-kit/models/members.dart';
import 'package:newhonekapp/ui-kit/models/reservation_item.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/member_card.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/reservation_card.dart';
import 'package:translator/translator.dart';

import '../../../ui-kit/utils/helper.dart';

class BookingView extends StatefulWidget {
  final int bookingIndex;
  const BookingView({super.key, required this.bookingIndex});
  @override
  createState() => _BookingView();
}

class _BookingView extends State<BookingView> {
  final translator = GoogleTranslator();
  String booking = 'Prenotazioni in corso';
  String client = 'Ospiti';
  String aggiungi = 'Aggiungi';

  getTransalations(String lang) async {
    var bookingCast =
        await translator.translate(booking, from: 'it', to: lang);
    var clientCast = await translator.translate(client, from: 'it', to: lang);
    var aggiungiCast =
        await translator.translate(aggiungi, from: 'it', to: lang);
    setState(() {
      booking = bookingCast.text;
      client = clientCast.text;
      aggiungi = aggiungiCast.text;
    });

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(
        pageActually: "bookings",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Spacer(),
                  Text(
                    booking,
                    style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      height: 1.5,
                      color: Color.fromARGB(255, 71, 80, 106),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: SizedBox(
                  child: ReservationCard(
                      reservationdata: ReservationModel(
                        archivate: false,
                          author: currentBooking
                              .value[widget.bookingIndex].author_id,
                          members: currentBooking.value[widget.bookingIndex].members,
                          email: "",
                          title: currentBooking
                              .value[widget.bookingIndex].name_structure,
                          date: '${currentBooking.value[widget.bookingIndex].startDate} alle ${currentBooking.value[widget.bookingIndex].endDate}',
                          nights:
                              currentBooking.value[widget.bookingIndex].night.toString(),
                          price:
                              currentBooking.value[widget.bookingIndex].price.toString(),
                          ipcamera:
                              currentBooking.value[widget.bookingIndex].ip,
                          index: widget.bookingIndex,
                          id: currentBooking.value[widget.bookingIndex].id,
                          checkinstate: currentBooking.value[widget.bookingIndex].status, 
                          )),
                )),
            SizedBox(
              height: 25.0,
            ),
            SizedBox(
                child: identical(
                        currentBooking.value[widget.bookingIndex].user_id,
                        currentUser.value.id)
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(children: [
                          Text(
                            client,
                            style: GoogleFonts.roboto(
                              fontSize: 26.0,
                              height: 1.5,
                              color: Color.fromARGB(255, 71, 80, 106),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          currentBooking.value[widget.bookingIndex].members.length < currentBooking.value[widget.bookingIndex].guests ?
                          InkWell(
                              onTap: () =>
                                  Helper.nextScreen(context, AddMemberEmail(bookingIndex: currentBooking.value[widget.bookingIndex].id)),
                              child: Row(children: [
                                Icon(Ionicons.add),
                                Text(aggiungi,
                                    style: GoogleFonts.roboto(fontSize: 18))
                              ])) : Text(
                            "Full",
                            style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              height: 1.5,
                              color: Color.fromARGB(255, 71, 80, 106),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ]))
                    : Text("")),
            SizedBox(
                child: identical(
                        currentBooking.value[widget.bookingIndex].user_id,
                        currentUser.value.id)
                    ? ValueListenableBuilder(
                        valueListenable: currentBooking,
                        builder: (BuildContext context, value, Widget? child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              for (var item in currentBooking.value[widget.bookingIndex].members)
                                MemberCard(
                                    memberData: MemberModel(
                                  email: item.email,
                                  name: '${item.name} ${item.lastname}',
                                  chekinDate: currentBooking
                                      .value[widget.bookingIndex].checkin_hour,
                                  childrens: '0',
                                  direction: item.direction.length > 20 ? "${item.direction.substring(0,19)}..." : item.direction ,
                                  endDate: currentBooking
                                      .value[widget.bookingIndex].endDate,
                                  member:
                                      currentMembers.value.length.toString(),
                                  note: "N/A",
                                  phone: item.mobile,
                                  roomID: currentBooking
                                      .value[widget.bookingIndex].namber_room,
                                  special: 'N/A',
                                  startDate: currentBooking
                                      .value[widget.bookingIndex].startDate,
                                  status: currentBooking
                                      .value[widget.bookingIndex].status,
                                )),
                            ],
                          );
                        },
                      )
                    : Text("")),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
