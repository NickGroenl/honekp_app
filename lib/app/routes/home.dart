import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/user.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/scan_blink.dart';
import 'package:newhonekapp/ui-kit/widgets/forms/dropdown.dart';
import 'package:newhonekapp/ui-kit/widgets/page_view.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:translator/translator.dart';

import '../../ui-kit/utils/helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController();
  String code_lang = 'it';
  int currentPage = 0;
  final translator = GoogleTranslator();
  String lang = 'Seleziona una lingua';
  String title1 = "Facile e veloce";
  String title2 = "Acceso facile";
  String title3 = "Semplifichiamo il tuo soggiorno";
  String description1 =
      "Prenota la cena in stanza con un semplice click. Entra in contatto con la struttura tramite chat. Prenota servizi extra direttamente della tua app.";
  String description2 =
      "Effettua l'accesso con i dati ricevuti con la prenotazione. Dopo aver effettuato il Check-in l'accesso e la prenotazione saranno legate per tutto il periodo di soggiorno.";
  String description3 =
      "Accendendo al mondo Honek avrai a disposizione tutta una miriade di funzionalita che renderanno il tuo soggiorno piu smart.";

  getTransalations(String lang) async {
    var langCast = await translator.translate(lang, from: 'it', to: lang);
    var title1Cast = await translator.translate(title1, from: 'it', to: lang);
    var title2Cast = await translator.translate(title2, from: 'it', to: lang);
    var title3Cast = await translator.translate(title3, from: 'it', to: lang);
    var descriptionCast1 =
        await translator.translate(description1, from: 'it', to: lang);
    var descriptionCast2 =
        await translator.translate(description2, from: 'it', to: lang);
    var descriptionCast3 =
        await translator.translate(description3, from: 'it', to: lang);

    setState(() {
      lang = langCast.text;
      title1 = title1Cast.text;
      title2 = title2Cast.text;
      title3 = title3Cast.text;
      description1 = descriptionCast1.text;
      description2 = descriptionCast2.text;
      description3 = descriptionCast3.text;
    });

    return false;
  }

  Future<void> verifySession(context) async {
    if (await getUser(false)) {
      Helper.nextScreen(context, Dashboard());
    }
  }

  @override
  void initState() {
    super.initState();

    getTransalations(currentUser.value.default_language != ''
        ? currentUser.value.default_language
        : 'it');
    () async {
      Future.delayed(Duration.zero);
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(children: [
                  Text(
                    lang,
                    style: GoogleFonts.roboto(
                      fontSize: 30.0,
                      height: 1.5,
                      color: Color.fromARGB(255, 45, 46, 50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppDropdownInput(
                    hintText: lang,
                    options: getLangNames().map((e) => e).toList(),
                    value: "Italian",
                    getLabel: (String? value) => value!,
                    onChanged: (value) => {
                      currentUser.value.default_language =
                          getLangCodes()[getLangNames().indexOf(value)]!
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  PrimaryButton(
                      text: 'Salva',
                      onPressed: () async => {
                            currentUser.value.default_language = code_lang,
                            getTransalations(code_lang),
                            Navigator.of(context).pop(),
                          })
                ]));
          });
      await verifySession(context);
    };
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        // Since all pages follow same pattern, let's make a template for them
        children: [
          code_lang != ''
              ? PageViewTemplate(
                  activePage: currentPage,
                  title: title1,
                  imagePath: "assets/images/logo.png",
                  textDescription: description1,
                )
              : Text(''),
          code_lang != ''
              ? PageViewTemplate(
                  activePage: currentPage,
                  title: title2,
                  imagePath: "assets/images/logo.png",
                  textDescription: description2)
              : Text(''),
          code_lang != ''
              ? PageViewTemplate(
                  activePage: currentPage,
                  title: title3,
                  imagePath: "assets/images/logo.png",
                  textDescription: description3)
              : Text(''),
        ],
      ),
    );
  }
}
