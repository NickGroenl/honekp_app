import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/scan_blink.dart';
import 'package:newhonekapp/ui-kit/models/reservation_item.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/reservation_card.dart';
import 'package:translator/translator.dart';

import '../user/user_configuration.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  createState() => _BookingList();
}

class _BookingList extends State<BookingList> {
  String booking = 'Prenotazioni';
  String active = "Attive";
  String nonHai = "Non abbiamo trovato prenotazioni attive";
  String nonCi = "Non ci sono prenotazioni archiviate";
  String archive = 'Archiviate';
  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var bookingCast = await translator.translate(booking, from: 'it', to: lang);
    var activeCast = await translator.translate(active, from: 'it', to: lang);
    var nonHaiCast = await translator.translate(nonHai, from: 'it', to: lang);
    var nonCiCast = await translator.translate(nonCi, from: 'it', to: lang);
    var archiveCast = await translator.translate(archive, from: 'it', to: lang);
    setState(() {
      booking = bookingCast.text;
      active = activeCast.text;
      nonHai = nonHaiCast.text;
      nonCi = nonCiCast.text;
      archive = archiveCast.text;
    });

    return false;
  }

  Future verifySession(context) async {
    if ((currentUser.value.image == '') ||
        (currentUser.value.back_image == '' ||
            currentUser.value.front_image == '')) {
      Helper.nextScreen(context, VerifyIdentity(lang: false));
    }
  }

  @override
  void initState() {
    super.initState();
    () async {
      await getTranslations(currentUser.value.default_language);
      // ignore: use_build_context_synchronously
      await verifySession(context);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(pageActually: "bookings"),
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
                  BackButton(
                    onPressed: () => Helper.nextScreen(context, Dashboard()),
                  ),
                  Text(
                    booking,
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
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                active,
                style: GoogleFonts.roboto(
                  fontSize: 26.0,
                  height: 1.5,
                  color: Color.fromARGB(255, 71, 80, 106),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ValueListenableBuilder(
              valueListenable: currentBooking,
              builder: (BuildContext context, value, Widget? child) {
                return currentBooking.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Text(
                          nonHai,
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
                            if (currentBooking.value.isNotEmpty)
                              for (var index = 0;
                                  index < currentBooking.value.length;
                                  index++)
                                ReservationCard(
                                    reservationdata: ReservationModel(
                                        archivate: false,
                                        author: currentBooking
                                            .value[index].author_id,
                                        members:
                                            currentBooking.value[index].members,
                                        email: "",
                                        title: currentBooking
                                            .value[index].name_structure,
                                        date:
                                            '${currentBooking.value[index].startDate} alle ${currentBooking.value[index].endDate}',
                                        nights: currentBooking
                                            .value[index].night
                                            .toString(),
                                        price: currentBooking.value[index].price
                                            .toString(),
                                        ipcamera:
                                            currentBooking.value[index].ip,
                                        index: index,
                                        id: currentBooking.value[index].id,
                                        checkinstate:
                                            currentBooking.value[index].status))
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
              child: Text(
                archive,
                style: GoogleFonts.roboto(
                  fontSize: 26.0,
                  height: 1.5,
                  color: Color.fromARGB(255, 71, 80, 106),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ValueListenableBuilder(
              valueListenable: currentAllBookings,
              builder: (BuildContext context, value, Widget? child) {
                return currentAllBookings.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Text(nonCi,
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
                            for (var item in currentAllBookings.value)
                              ReservationCard(
                                  reservationdata: ReservationModel(
                                      archivate: true,
                                      author: item.author_id,
                                      members: [],
                                      email: "",
                                      title: item.name_structure,
                                      date:
                                          '${item.startDate} alle ${item.endDate}',
                                      nights: item.night.toString(),
                                      price: item.price.toString(),
                                      ipcamera: '',
                                      index: currentAllBookings.value
                                          .indexOf(item),
                                      id: item.id,
                                      checkinstate: item.status))
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
