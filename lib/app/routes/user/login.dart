import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:translator/translator.dart';

import '../../views/user_login.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  createState() => _Login();
}

class _Login extends State<Login> {
  final translator = GoogleTranslator();
  String mettiamo =   'Ti mettiamo a disposizione la possibilità di accedere a funzionalità che renderanno la tua esperienza presso la struttura unica.';
  String rendiamo = 'Rendiamo unico il tuo soggiorno.';
  String effetua  = 'Effetua il login con i dati ricevuti per mail dopo la prenotazione così da poter completare il self check-in online ed entrare in App per iniziare a gestire il tuo soggiorno.';

  getTransalations(String lang) async {
    var title1Cast = await translator.translate(mettiamo, from: 'it', to: lang);
    var title2Cast = await translator.translate(rendiamo, from: 'it', to: lang);
    var title3Cast = await translator.translate(effetua, from: 'it', to: lang);
   
    setState(() {
      mettiamo = title1Cast.text;
      rendiamo = title2Cast.text;
      effetua = title3Cast.text;

    });

    return false;
  }
  @override
  void initState() {
    super.initState();
    getTransalations(currentUser.value.default_language != '' ? currentUser.value.default_language : 'en');
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Wrap(
                  children: [
                    SafeArea(child: SizedBox()),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 30.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: double.infinity,
                      child: Column(
                        children:  [
                          SizedBox(
                            height: 55.0,
                          ),
                          Image(
                            semanticLabel: "assets/images/logo.png",
                            image: AssetImage("assets/images/logo.png"),
                            width: 150,
                            height: 48,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                          rendiamo,
                            style: GoogleFonts.roboto(
                              fontSize: 25.0,
                              height: 1.5,
                              color: Color.fromARGB(255, 45, 46, 50),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                          mettiamo,
                            style: GoogleFonts.roboto(
                              fontSize: 17.0,
                              height: 1.5,
                              color: Color.fromARGB(185, 45, 46, 50),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                          effetua,
                            style: GoogleFonts.roboto(
                              fontSize: 17.0,
                              height: 1.5,
                              color: Color.fromARGB(220, 45, 46, 50),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          //Leta take the form to a new page
                          LoginForm(),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
