// ignore_for_file: unrelated_type_equality_checks

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../../../ui-kit/widgets/primary_button.dart';
import '../../../models/user.dart';
import '../../../repository/user.dart';

class MarketingConfiguration extends StatefulWidget {
  const MarketingConfiguration({super.key});
  @override
  createState() => _MarketingConfiguration();
}

class _MarketingConfiguration extends State<MarketingConfiguration> {
  late bool sms;
  late bool mail;
  late bool newsteller;
  late String stateMessage = '';
  String saveDates = 'Hai modificato i tuoi dati';
  String type = "Tipo di Comunicazione";

  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var typeCast = await translator.translate(type, from: 'it', to: lang);

    var saveDatesCast =
        await translator.translate(saveDates, from: 'it', to: lang);
    setState(() {
      type = typeCast.text;
      saveDates = saveDatesCast.text;
    });

    return false;
  }

  @override
  void initState() {
    super.initState();
    getTranslations(currentUser.value.default_language);
    sms = currentUser.value.marketing_sms == 1 ? true : false;
    mail = currentUser.value.marketing_mail == 1 ? true : false;
    newsteller = currentUser.value.marketing_newsletter == 1 ? true : false;
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
                                Text(
                                  type,
                                  style: GoogleFonts.roboto(
                                    fontSize: 20.0,
                                    color: Color.fromARGB(255, 51, 52, 53),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                CheckboxListTile(
                                  value: mail,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      mail = value!;
                                    });
                                  },
                                  title: Text(
                                    "Mail",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20.0,
                                      color: Color.fromRGBO(138, 150, 191, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                CheckboxListTile(
                                  value: sms,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      sms = value!;
                                    });
                                  },
                                  title: Text(
                                    "SMS",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20.0,
                                      color: Color.fromRGBO(138, 150, 191, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                CheckboxListTile(
                                  value: newsteller,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      newsteller = value!;
                                    });
                                  },
                                  title: Text(
                                    "Newsteller",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20.0,
                                      color: Color.fromRGBO(138, 150, 191, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35.0,
                                ),
                                Text(
                                  stateMessage,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 77, 131, 72),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                PrimaryButton(
                                    text: "Salva",
                                    onPressed: () async => {
                                          if (await updateMarketing({
                                            'name': currentUser.value.name,
                                            'marketing_communication': {
                                              'sms': sms == true ? 1 : 0,
                                              'mail': mail == true ? 1 : 0,
                                              'newsletter':
                                                  newsteller == true ? 1 : 0
                                            }
                                          }))
                                            {
                                              await getUser(false),
                                              setState(() {
                                                stateMessage = saveDates;
                                              })
                                            }
                                        }),
                                SizedBox(
                                  height: 25.0,
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
