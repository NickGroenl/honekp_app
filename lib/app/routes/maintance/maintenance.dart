import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/maintenance.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/maintance/add_maintance.dart';
import 'package:newhonekapp/app/routes/maintance/maintance_view.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:translator/translator.dart';

class Maintance extends StatefulWidget {
  const Maintance({super.key});

  @override
  createState() => _Maintance();
}

class _Maintance extends State<Maintance> {
  final translator = GoogleTranslator();
  String maintenance = 'Manutenzione';
  String dontMaintenance = "Non ci sono manutenzioni attive";

  getTranslations(String lang) async {
    var maintenanceCast =
        await translator.translate(maintenance, from: 'it', to: lang);
    var dontMaintenanceCast =
        await translator.translate(dontMaintenance, from: 'it', to: lang);

    setState(() {
      maintenance = maintenanceCast.text;
      dontMaintenance = dontMaintenanceCast.text;
    });

    return false;
  }

  @override
  void initState() {
    super.initState();
    getTranslations(currentUser.value.default_language);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentMaintenances,
        builder: (BuildContext context, value, Widget? child) {
          return Scaffold(
            bottomNavigationBar: AppBottomNavigation(pageActually: "maintance"),
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
                        BackButton(
                          onPressed: () =>
                              Helper.nextScreen(context, Dashboard()),
                        ),
                        Text(
                          maintenance,
                          style: GoogleFonts.roboto(
                            fontSize: 20.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 71, 80, 106),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                            onTap: () => currentBooking.value.isNotEmpty
                                ? Helper.nextScreen(context, AddMaintance())
                                : '',
                            child: SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: Icon(
                                Ionicons.add_outline,
                                size: 25,
                                color: Constants.primaryColor,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  currentMaintenances.value.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(dontMaintenance,
                              style: GoogleFonts.roboto(
                                fontSize: 18.0,
                                height: 1.5,
                                color: Color.fromARGB(255, 76, 79, 90),
                                fontWeight: FontWeight.w400,
                              )))
                      : Column(children: [
                          for (var item in currentMaintenances.value)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Card(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            item.reason.length > 16
                                                ? "${item.reason.substring(0, 16)}..."
                                                : item.reason,
                                            style: GoogleFonts.roboto(
                                              fontSize: 18.0,
                                              height: 1.5,
                                              color: Color.fromARGB(
                                                  255, 58, 59, 60),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          InkWell(
                                              onTap: () => Helper.nextScreen(
                                                  context,
                                                  MaintanceView(
                                                      maintenance: item)),
                                              child: SizedBox(
                                                height: 20.0,
                                                width: 20.0,
                                                child: Icon(
                                                  Ionicons
                                                      .arrow_forward_outline,
                                                  size: 18,
                                                  color: Constants.primaryColor,
                                                ),
                                              )),
                                          SizedBox(height: 8),
                                        ],
                                      ))),
                            ),
                        ]),
                ],
              ),
            ),
          );
        });
  }
}
