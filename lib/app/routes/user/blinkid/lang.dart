
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/user.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/scan_blink.dart';
import 'package:newhonekapp/app/routes/user/login.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:translator/translator.dart';

import '../../../../ui-kit/widgets/forms/dropdown.dart';

class LangSelect extends StatefulWidget {
  final String route;
  const LangSelect({super.key, required this.route});

  @override
  createState() => _LangSelect();
}

class _LangSelect extends State<LangSelect> {
  final translator = GoogleTranslator();
  String enter =   'Enter in Honek';
  String select = 'Select your language';
  String welcome = 'Welcome';
  String code_lang = 'it';
  getTransalations(String lang) async {
    var title1Cast = await translator.translate(enter, from: 'it', to: lang);
    var title2Cast = await translator.translate(select, from: 'it', to: lang);
    var title3Cast = await translator.translate(welcome, from: 'it', to: lang);
   
    setState(() {
      enter = title1Cast.text;
      select = title2Cast.text;
      welcome = title3Cast.text;

    });

    return false;
  }
  @override
  void initState() {
    super.initState();
    if(currentUser.value.default_language != ''){
      if(widget.route != '/login'){
        Helper.nextScreen(context, VerifyIdentity(lang: false,));
      }
    }    
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
              children:  [
                  SafeArea(child: SizedBox()),
                  SizedBox(
                    height: 18.0,
                  ),
                  Center(child: Image(
                            semanticLabel: "assets/images/logo.png",
                            image: AssetImage("assets/images/logo.png"),
                            width: 150,
                            height: 48,
                          ),),
                          SizedBox(height: 95,),
                        Text(
                          welcome,
                            style: GoogleFonts.roboto(
                              fontStyle: FontStyle.normal,
                              fontSize: 45.0,
                              height: 1.5,
                              color: Color.fromARGB(255, 45, 46, 50),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 35,),
                          Text(
                          select,
                            style: GoogleFonts.roboto(
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0,
                              color: Color.fromARGB(203, 45, 46, 50),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        SizedBox(height: 35,),

                        Padding(padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10), child: AppDropdownInput(
                          hintText: 'lang',
                          options: getLangNames().map((e) => e).toList(),
                          value: "Italian",
                          getLabel: (String? value) => value!,
                          onChanged: (value) => {
                            setState(() {
                              code_lang =
                                  getLangCodes()[getLangNames().indexOf(value)]!;
                            }),
                          },
                    ),),
                    SizedBox(height: 115,),
                    PrimaryButton(
                        text: enter,
                        onPressed: () async => {
                          currentUser.value.default_language = code_lang,
                          
                          await updateProfile({
                                "language": code_lang,
                                "currency": currentUser.value.currency == ''
                                    ? 'eur'
                                    : currentUser.value.currency,
                                "phone": currentUser.value.mobile != ''
                                    ? currentUser.value.mobile
                                    : 'Complete'
                            }),
                            if(widget.route == '/login'){
                              Helper.nextScreen(context, Login())
                            } else {
                              Helper.nextScreen(context, VerifyIdentity(lang: false,))
                            },
                              
                            })
              ],
            ),
          );
        }),
      ),
    );
  }
}

/*Padding(
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
                        setState(() {
                          code_lang =
                              getLangCodes()[getLangNames().indexOf(value)]!;
                        }),
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    PrimaryButton(
                        text: stepFour,
                        onPressed: () async => {
                              if (await updateProfile({
                                "language": code_lang,
                                "currency": currentUser.value.currency == ''
                                    ? 'eur'
                                    : currentUser.value.currency,
                                "phone": currentUser.value.mobile != ''
                                    ? currentUser.value.mobile
                                    : 'Complete'
                              }))
                                {
                                  currentUser.value.default_language =
                                      code_lang,
                                  getTranslations(code_lang),
                                  Navigator.of(context).pop(),
                                }
                            })
                  ]));*/