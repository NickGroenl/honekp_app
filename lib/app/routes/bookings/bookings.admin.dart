import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/bookings.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/ui-kit/models/reservation_item.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/booking.admin.card.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/reservation_card.dart';
import 'package:translator/translator.dart';

import '../user/user_configuration.dart';

class BookingListAdmin extends StatefulWidget {
  const BookingListAdmin({super.key});

  @override
  createState() => _BookingListAdmin();
}

class _BookingListAdmin extends State<BookingListAdmin> {
  final DateTime currentTime = DateTime.now();

  final translator = GoogleTranslator();
  String exitTime = 'Partenze del';
  String dontExitToday = "Non ci sono partenze oggi";
  String openTime = 'Arriva del';
  String dontOpenToday = 'Aggiungi';
  String inHotel = 'In hotel oggi';
  String dontKeeping = "Nessuna camera impegnata oggi";
  getTransalations(String lang) async {
    var exitTimeCast =
        await translator.translate(exitTime, from: 'it', to: lang);
    var dontExitTodayCast =
        await translator.translate(dontExitToday, from: 'it', to: lang);
    var openTimeCast =
        await translator.translate(openTime, from: 'it', to: lang);
    var dontOpenTodayCast =
        await translator.translate(dontOpenToday, from: 'it', to: lang);
    var inHotelCast = await translator.translate(inHotel, from: 'it', to: lang);
    var dontKeepingCast =
        await translator.translate(dontKeeping, from: 'it', to: lang);

    setState(() {
      exitTime = exitTimeCast.text;
      dontExitToday = dontExitTodayCast.text;
      openTime = openTimeCast.text;
      dontOpenToday = dontOpenTodayCast.text;
      inHotel = inHotelCast.text;
      dontKeeping = dontKeepingCast.text;
    });

    return false;
  }

  Future verifySession(context) async {
    await getAllBookingsAdministrator({
      "id": currentUser.value.parentId != 0
          ? currentUser.value.parentId
          : currentUser.value.id
    });
  }

  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(Duration.zero);
      // ignore: use_build_context_synchronously
      await verifySession(context);
      await getTransalations(currentUser.value.default_language);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(pageActually: "home"),
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
                  InkWell(
                    onTap: () {},
                    child: Image(
                      semanticLabel: "assets/images/logo.png",
                      image: AssetImage("assets/images/logo.png"),
                      width: 90,
                      height: 38,
                    ),
                  ),
                  Text(
                    "Dashboard",
                    style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      height: 1.5,
                      color: Color.fromARGB(255, 71, 80, 106),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                      onTap: () =>
                          Helper.nextScreen(context, UserConfiguration()),
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    currentUser.value.image != ''
                                        ? "$baseUrl/${currentUser.value.image}"
                                        : ''),
                                fit: BoxFit.cover),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0)
                            ]),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Icon(Ionicons.airplane_outline),
                  SizedBox(
                    width: 10,
                  ),
                  Text("$exitTime ${currentTime.day}/${currentTime.month}",
                      style: GoogleFonts.roboto(
                        fontSize: 26.0,
                        height: 1.5,
                        color: Color.fromARGB(255, 71, 80, 106),
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ValueListenableBuilder(
              valueListenable: oldedAdmninistratorBookings,
              builder: (BuildContext context, value, Widget? child) {
                return oldedAdmninistratorBookings.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Text(dontExitToday,
                            style: GoogleFonts.roboto(
                              fontSize: 18.0,
                              height: 1.5,
                              color: Color.fromARGB(255, 76, 79, 90),
                              fontWeight: FontWeight.w400,
                            )))
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            for (var item in oldedAdmninistratorBookings.value)
                              BookingAdministratorCard(
                                date_end: item.status,
                                house_keeping: item.house_keeping,
                                room_name: item.bookingNumber,
                                user_name: item.members.isNotEmpty
                                    ? '${item.members[0].name} ${item.members[0].lastname}'
                                    : '',
                                guests: item.guests,
                                nights: item.night - 1,
                              )
                          ],
                        ),
                      );
              },
            ),
            SizedBox(
              height: 35.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Icon(Ionicons.airplane_outline),
                  SizedBox(
                    width: 10,
                  ),
                  Text("$dontOpenToday ${currentTime.day}/${currentTime.month}",
                      style: GoogleFonts.roboto(
                        fontSize: 26.0,
                        height: 1.5,
                        color: Color.fromARGB(255, 71, 80, 106),
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ValueListenableBuilder(
              valueListenable: newsAdministratorBookings,
              builder: (BuildContext context, value, Widget? child) {
                return newsAdministratorBookings.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Text(
                          dontOpenToday,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 76, 79, 90),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            if (newsAdministratorBookings.value.isNotEmpty)
                              for (var item in newsAdministratorBookings.value)
                                BookingAdministratorCard(
                                  date_end: item.status,
                                  house_keeping: item.house_keeping,
                                  room_name: item.bookingNumber,
                                  user_name: item.members.isNotEmpty
                                      ? '${item.members[0].name} ${item.members[0].lastname}'
                                      : '',
                                  guests: item.guests,
                                  nights: item.night,
                                )
                          ],
                        ),
                      );
              },
            ),
            SizedBox(
              height: 35.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Icon(Ionicons.bed_outline),
                  SizedBox(
                    width: 10,
                  ),
                  Text(inHotel,
                      style: GoogleFonts.roboto(
                        fontSize: 26.0,
                        height: 1.5,
                        color: Color.fromARGB(255, 71, 80, 106),
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ValueListenableBuilder(
              valueListenable: currentAdministratorBookings,
              builder: (BuildContext context, value, Widget? child) {
                return currentAdministratorBookings.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Text(dontKeeping,
                            style: GoogleFonts.roboto(
                              fontSize: 18.0,
                              height: 1.5,
                              color: Color.fromARGB(255, 76, 79, 90),
                              fontWeight: FontWeight.w400,
                            )))
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            for (var item in currentAdministratorBookings.value)
                              BookingAdministratorCard(
                                date_end: item.status,
                                house_keeping: item.house_keeping,
                                room_name: item.bookingNumber,
                                user_name: item.members.isNotEmpty
                                    ? '${item.members[0].name} ${item.members[0].lastname}'
                                    : '',
                                guests: item.guests,
                                nights: item.night - 1,
                              )
                          ],
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
