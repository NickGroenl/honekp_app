// ignore_for_file: avoid_print
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/chat.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/repository/maintenance.dart';
import 'package:newhonekapp/app/repository/shop.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/insert_dates.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/lang.dart';
import 'package:newhonekapp/app/routes/user/configuration/billing.dart';
import 'package:newhonekapp/app/routes/user/login.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/scan_blink.dart';
import 'package:newhonekapp/app/routes/user/user_configuration.dart';
import 'package:newhonekapp/app/static/constants.dart';
import 'package:newhonekapp/ui-kit/models/reservation_item.dart';
import 'package:newhonekapp/ui-kit/widgets/forms/dropdown.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/touch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/reservation_card.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:translator/translator.dart';
import '../../../ui-kit/utils/helper.dart';
import '../../repository/bookings.dart';
import '../../repository/user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final translator = GoogleTranslator();
  String prenotazione = 'Prenotazioni in corso';
  String nonHaiPrenotazioni = 'Non hai prenotazioni in corso';
  String destinazioni = "Destinazioni popolari";
  String camera = 'Camera';
  getTransalations(String lang) async {
    var prenotazioniCast =
        await translator.translate(prenotazione, from: 'it', to: lang);
    var nonHaiCast =
        await translator.translate(nonHaiPrenotazioni, from: 'it', to: lang);
    var destinazioniCast =
        await translator.translate(destinazioni, from: 'it', to: lang);
    var cameraCast =
        await translator.translate(camera, from: 'it', to: lang);
    setState(() {
      prenotazione = prenotazioniCast.text;
      nonHaiPrenotazioni = nonHaiCast.text;
      destinazioni = destinazioniCast.text;
      camera = cameraCast.text;
    });

    return false;
  }

  Future verifySession(context) async {
    if (!await getUser(true)) {
      Helper.nextScreen(context, Login());
    } else {
      // ignore: unnecessary_null_comparison
      if ((currentUser.value.image == '' || currentUser.value.image == null) ||
          (currentUser.value.back_image == '' ||
              currentUser.value.front_image == '') ||
          (currentUser.value.image ==
              'https://honek.labict.it/images/user.jpg')) {
        Helper.nextScreen(context, LangSelect(route: '/asd',));
      } else {
        if (currentUser.value.sdi_code == '') {
          Helper.nextScreen(
              context,
              BillingConfiguration(
                back: false, scanningManual: true, steps: true,
              ));
        } else {
          if (currentUser.value.sdi_code == '' || currentUser.value.sdi_code == 'nulling') {
            Helper.nextScreen(context, BlinkDatesConfiguration());
          }
          await getShops();
          await getAllBookings();
          await getMaintenances();
          await getMainteners();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(Duration.zero);
      await getTransalations(currentUser.value.default_language);     
      // ignore: use_build_context_synchronously
      await verifySession(context);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(
        pageActually: "home",
      ),
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
                  InkWell(
                    onTap: () {},
                    child: Image(
                      semanticLabel: "assets/images/logo.png",
                      image: AssetImage("assets/images/logo.png"),
                      width: 90,
                      height: 38,
                    ),
                  ),
                  ValueListenableBuilder(
                    builder: (BuildContext context, value, Widget? child) {
                      return InkWell(
                          onTap: () =>
                              Helper.nextScreen(context, UserConfiguration()),
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
                                      color: Colors.black12.withOpacity(0.1),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0)
                                ]),
                          ));
                    },
                    valueListenable: currentUser,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                prenotazione,
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
                return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: SizedBox(
                        // Lets create a model to structure property data
                        child: currentBooking.value.isEmpty
                            ? Text(
                                nonHaiPrenotazioni,
                                style: GoogleFonts.roboto(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  color: Color.fromARGB(255, 76, 79, 90),
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    for (var item in currentBooking.value)
                                      ReservationCard(
                                          reservationdata: ReservationModel(
                                              author: item.author_id,
                                              members: item.members,
                                              email: "",
                                              title: '${item.name_structure} - $camera ${item.namber_room}',
                                              date:
                                                  '${item.startDate} al ${item.endDate}',
                                              nights: item.night.toString(),
                                              price: item.price.toString(),
                                              ipcamera: item.ip,
                                              archivate: false,
                                              index: currentBooking.value
                                                  .indexOf(item),
                                              id: item.id,
                                              checkinstate: item.status))
                                  ],
                                ),
                              )));
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Text(
                destinazioni,
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
            SizedBox(
              height: ScreenUtil().setHeight(300.0),
              // Lets create a model to structure property data
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  // Lets create a property card widget
                  return TouchCard(
                    card: TravelStaticData.travels[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 10.0,
                  );
                },
                // Make the length our static data length
                itemCount: TravelStaticData.travels.length,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
