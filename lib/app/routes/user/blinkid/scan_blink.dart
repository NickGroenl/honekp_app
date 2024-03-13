// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/camera.services/camera-page.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/user.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/result.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/take_blink.dart';
import 'package:newhonekapp/ui-kit/widgets/forms/dropdown.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:translator/translator.dart';
import '../../../../ui-kit/utils/constants.dart';
import '../../../../ui-kit/utils/helper.dart';

const String androidLicenseFileName = 'license.key';
const String iosLicense =
    'sRwAAAETY29tLmxhYmljdGhvbmVrLmFwcMWqQ4MaSq8gfJCioisnRtlNEBRq92q28UcmbT5aF6e6wxuw/yWYIzntp3VzlAFy2N/D12EwvIGZJPd+Pf6NHlY/Ndc4n8vxFwDXmX773pF26zfjCKEaAXueRyNt9ab0Kq++HNJYf/vKchYdSz1gz0TAyTkaDNQna9p1VtzAPRNe1ziGrnglq9zhjrUlefDEAoaNgMCk8Hiqi9SULhLuKs6PQc3PXEGjIUL9nLRbO+Uu';

class VerifyIdentity extends StatefulWidget {
  final bool lang;
  const VerifyIdentity({super.key, required this.lang});

  @override
  createState() => _VerifyIdentity();
}

class _VerifyIdentity extends State<VerifyIdentity> {
  String title = "Procedura offline documenti cartacei";
  String title2 = "Verifica la tua identità";
  String title3 = 'La procedura di self check-in online richiederà circa 5 minuti';
  String richiedi = 'Richiedi verifica';
  String stepOne = "Assicurati di essere in un posto ben illuminato";
  String stepTwoo = "Verifica se il cellulare è connesso ad internet.";
  String stepThree = "Tieni a portata di mano il tuo documento di identità elettronico in corso di valità.";
  String stepFour = "Effetua la scansione del documento ed esegui il riconoscimento facciale.";
  String stepFive = "Inserisci i dati di fatturazione.";
  String consentire = "Consentire alla fotocamera di continuare";
  String abilita = "Abilita e inizia";
  String lang = 'Seleziona una lingua';
  String code_lang = 'it';

  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var titleCast = await translator.translate(title, from: 'it', to: lang);
    var title2Cast = await translator.translate(title2, from: 'it', to: lang);
    var title3Cast = await translator.translate(title3, from: 'it', to: lang);
    var richiediCast =
        await translator.translate(richiedi, from: 'it', to: lang);
    var stepOneCast = await translator.translate(stepOne, from: 'it', to: lang);
    var stepTwooCast =
        await translator.translate(stepTwoo, from: 'it', to: lang);
    var stepThreeCast =
        await translator.translate(stepThree, from: 'it', to: lang);
    var stepFourCast =
        await translator.translate(stepFour, from: 'it', to: lang);
    var stepFiveCast =
        await translator.translate(stepFive, from: 'it', to: lang);
    var consentireCast =
        await translator.translate(consentire, from: 'it', to: lang);
    var abilitaCast = await translator.translate(abilita, from: 'it', to: lang);
    var langCast = await translator.translate(lang, from: 'it', to: lang);

    setState(() {
      title = titleCast.text;
      title2 = title2Cast.text;
      title3 = title3Cast.text;
      richiedi = richiediCast.text;
      stepOne = stepOneCast.text;
      stepTwoo = stepTwooCast.text;
      stepThree = stepThreeCast.text;
      stepFour = stepFourCast.text;
      stepFive = stepFiveCast.text;
      consentire = consentireCast.text;
      abilita = abilitaCast.text;
      lang = langCast.text;
    });

    return false;
  }

  @override
  void initState() {
    super.initState();

    () async {
      await Future.delayed(Duration.zero);
      await getUser(false);
      await getTranslations(currentUser.value.default_language != ''
          ? currentUser.value.default_language
          : 'en');

      if (widget.lang) {
        
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            
                    SizedBox(height: 5),
                    PrimaryButton(text: abilita, onPressed: () => Helper.nextScreen(context, BlinkInit())),
            
            
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async => {
                Helper.nextScreen(
                    context,
                    TakePictureScreen(
                      lang: currentUser.value.default_language,
                    ))
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white.withOpacity(0),
              ),
              
              child: SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    title,
                    style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ))),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SafeArea(child: SizedBox()),
                    Image(
                            semanticLabel: "assets/images/logo.png",
                            image: AssetImage("assets/images/logo.png"),
                            width: 150,
                            height: 48,
                    ),
                    SizedBox(height: 25,),
                    Row(
                      children: <Widget>[
                        // ...
                        
                        DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Constants.primaryColor,
                                  width: 2,
                                ),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "1",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        Expanded(child: Divider(color: Colors.black)),
                        DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "2",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        Expanded(child: Divider(color: Colors.black)),
                        DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "3",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 35,),
                    Text(
                      title2,
                      style: GoogleFonts.roboto(
                        fontSize: 30.0,
                        height: 1.5,
                        color: Color.fromARGB(255, 45, 46, 50),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$title3',
                      style: GoogleFonts.roboto(
                        fontSize: 22.0,
                        height: 1.5,
                        color: Color.fromARGB(255, 94, 97, 105),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 45),
                    
                   
                          Row(children: [Icon(Ionicons.sunny_outline, size: 20,),
                      SizedBox(width: 10,),
                      Expanded(child: Text(
                          stepOne,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 55, 55, 56),
                            fontWeight: FontWeight.w600,
                          ),)
                        ),],),
                      
                    

                      
                    SizedBox(height: 10),
                    Row(children: [
                      Icon(Ionicons.wifi_outline, size: 20,),
                      SizedBox(width: 10,),
                      Expanded(child: Text(
                          stepTwoo,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 55, 55, 56),
                            fontWeight: FontWeight.w600,
                          ),
                        ),)
                    ],
                    ),
                        
                      
                    
                    SizedBox(height: 10),
                    
                        
                    Row(children: [
                      Icon(Ionicons.expand_outline, size: 20,),
                      SizedBox(width: 10,),
                      Expanded(child: Text(
                          stepThree,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 55, 55, 56),
                            fontWeight: FontWeight.w600,
                          ),
                        ))
                    ],
                    ),
                      
                    SizedBox(height: 10),
                    
                    Row(children: [
                      Icon(Ionicons.person_outline, size: 20,),
                      SizedBox(width: 10,),
                      Expanded(child: Text(
                          stepFour,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 55, 55, 56),
                            fontWeight: FontWeight.w600,
                          ),
                        ),)
                    ],
                    ),
                      
                    SizedBox(height: 10),
                    
                    Row(children: [
                      Icon(Ionicons.pencil_outline, size: 20,),
                      SizedBox(width: 10,),
                      Expanded(child: Text(
                          stepFive,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 55, 55, 56),
                            fontWeight: FontWeight.w600,
                          ),
                        ),)
                    ],
                    ),
                      
                    
                    
                    
                  ]));
        }),
      ),
    );
  }
}

List<String?> getLangCodes() {
  List<String?> codes = lang_codes.map((e) => e["code"]).toList();
  return codes;
}

List<String?> getLangNames() {
  List<String?> names = lang_codes.map((e) => e["name"]).toList();
  return names;
}

List<Map<String, String>> lang_codes = [
  {"code": "ab", "name": "Abkhaz", "nativeName": "аҧсуа"},
  {"code": "aa", "name": "Afar", "nativeName": "Afaraf"},
  {"code": "af", "name": "Afrikaans", "nativeName": "Afrikaans"},
  {"code": "ak", "name": "Akan", "nativeName": "Akan"},
  {"code": "sq", "name": "Albanian", "nativeName": "Shqip"},
  {"code": "am", "name": "Amharic", "nativeName": "አማርኛ"},
  {"code": "ar", "name": "Arabic", "nativeName": "العربية"},
  {"code": "an", "name": "Aragonese", "nativeName": "Aragonés"},
  {"code": "hy", "name": "Armenian", "nativeName": "Հայերեն"},
  {"code": "as", "name": "Assamese", "nativeName": "অসমীয়া"},
  {"code": "av", "name": "Avaric", "nativeName": "авар мацӀ, магӀарул мацӀ"},
  {"code": "ae", "name": "Avestan", "nativeName": "avesta"},
  {"code": "ay", "name": "Aymara", "nativeName": "aymar aru"},
  {"code": "az", "name": "Azerbaijani", "nativeName": "azərbaycan dili"},
  {"code": "bm", "name": "Bambara", "nativeName": "bamanankan"},
  {"code": "ba", "name": "Bashkir", "nativeName": "башҡорт теле"},
  {"code": "eu", "name": "Basque", "nativeName": "euskara, euskera"},
  {"code": "be", "name": "Belarusian", "nativeName": "Беларуская"},
  {"code": "bn", "name": "Bengali", "nativeName": "বাংলা"},
  {"code": "bh", "name": "Bihari", "nativeName": "भोजपुरी"},
  {"code": "bi", "name": "Bislama", "nativeName": "Bislama"},
  {"code": "bs", "name": "Bosnian", "nativeName": "bosanski jezik"},
  {"code": "br", "name": "Breton", "nativeName": "brezhoneg"},
  {"code": "bg", "name": "Bulgarian", "nativeName": "български език"},
  {"code": "my", "name": "Burmese", "nativeName": "ဗမာစာ"},
  {"code": "ca", "name": "Catalan; Valencian", "nativeName": "Català"},
  {"code": "ch", "name": "Chamorro", "nativeName": "Chamoru"},
  {"code": "ce", "name": "Chechen", "nativeName": "нохчийн мотт"},
  {
    "code": "ny",
    "name": "Chichewa; Chewa; Nyanja",
    "nativeName": "chiCheŵa, chinyanja"
  },
  {"code": "zh", "name": "Chinese", "nativeName": "中文 (Zhōngwén), 汉语, 漢語"},
  {"code": "cv", "name": "Chuvash", "nativeName": "чӑваш чӗлхи"},
  {"code": "kw", "name": "Cornish", "nativeName": "Kernewek"},
  {"code": "co", "name": "Corsican", "nativeName": "corsu, lingua corsa"},
  {"code": "cr", "name": "Cree", "nativeName": "ᓀᐦᐃᔭᐍᐏᐣ"},
  {"code": "hr", "name": "Croatian", "nativeName": "hrvatski"},
  {"code": "cs", "name": "Czech", "nativeName": "česky, čeština"},
  {"code": "da", "name": "Danish", "nativeName": "dansk"},
  {"code": "dv", "name": "Divehi; Dhivehi; Maldivian;", "nativeName": "ދިވެހި"},
  {"code": "nl", "name": "Dutch", "nativeName": "Nederlands, Vlaams"},
  {"code": "en", "name": "English", "nativeName": "English"},
  {"code": "eo", "name": "Esperanto", "nativeName": "Esperanto"},
  {"code": "et", "name": "Estonian", "nativeName": "eesti, eesti keel"},
  {"code": "ee", "name": "Ewe", "nativeName": "Eʋegbe"},
  {"code": "fo", "name": "Faroese", "nativeName": "føroyskt"},
  {"code": "fj", "name": "Fijian", "nativeName": "vosa Vakaviti"},
  {"code": "fi", "name": "Finnish", "nativeName": "suomi, suomen kieli"},
  {"code": "fr", "name": "French", "nativeName": "français, langue française"},
  {
    "code": "ff",
    "name": "Fula; Fulah; Pulaar; Pular",
    "nativeName": "Fulfulde, Pulaar, Pular"
  },
  {"code": "gl", "name": "Galician", "nativeName": "Galego"},
  {"code": "ka", "name": "Georgian", "nativeName": "ქართული"},
  {"code": "de", "name": "German", "nativeName": "Deutsch"},
  {"code": "el", "name": "Greek, Modern", "nativeName": "Ελληνικά"},
  {"code": "gn", "name": "Guaraní", "nativeName": "Avañeẽ"},
  {"code": "gu", "name": "Gujarati", "nativeName": "ગુજરાતી"},
  {
    "code": "ht",
    "name": "Haitian; Haitian Creole",
    "nativeName": "Kreyòl ayisyen"
  },
  {"code": "ha", "name": "Hausa", "nativeName": "Hausa, هَوُسَ"},
  {"code": "he", "name": "Hebrew (modern)", "nativeName": "עברית"},
  {"code": "hz", "name": "Herero", "nativeName": "Otjiherero"},
  {"code": "hi", "name": "Hindi", "nativeName": "हिन्दी, हिंदी"},
  {"code": "ho", "name": "Hiri Motu", "nativeName": "Hiri Motu"},
  {"code": "hu", "name": "Hungarian", "nativeName": "Magyar"},
  {"code": "ia", "name": "Interlingua", "nativeName": "Interlingua"},
  {"code": "id", "name": "Indonesian", "nativeName": "Bahasa Indonesia"},
  {
    "code": "ie",
    "name": "Interlingue",
    "nativeName": "Originally called Occidental; then Interlingue after WWII"
  },
  {"code": "ga", "name": "Irish", "nativeName": "Gaeilge"},
  {"code": "ig", "name": "Igbo", "nativeName": "Asụsụ Igbo"},
  {"code": "ik", "name": "Inupiaq", "nativeName": "Iñupiaq, Iñupiatun"},
  {"code": "io", "name": "Ido", "nativeName": "Ido"},
  {"code": "is", "name": "Icelandic", "nativeName": "Íslenska"},
  {"code": "it", "name": "Italian", "nativeName": "Italiano"},
  {"code": "iu", "name": "Inuktitut", "nativeName": "ᐃᓄᒃᑎᑐᑦ"},
  {"code": "ja", "name": "Japanese", "nativeName": "日本語 (にほんご／にっぽんご)"},
  {"code": "jv", "name": "Javanese", "nativeName": "basa Jawa"},
  {
    "code": "kl",
    "name": "Kalaallisut, Greenlandic",
    "nativeName": "kalaallisut, kalaallit oqaasii"
  },
  {"code": "kn", "name": "Kannada", "nativeName": "ಕನ್ನಡ"},
  {"code": "kr", "name": "Kanuri", "nativeName": "Kanuri"},
  {"code": "kk", "name": "Kazakh", "nativeName": "Қазақ тілі"},
  {"code": "km", "name": "Khmer", "nativeName": "ភាសាខ្មែរ"},
  {"code": "ki", "name": "Kikuyu, Gikuyu", "nativeName": "Gĩkũyũ"},
  {"code": "rw", "name": "Kinyarwanda", "nativeName": "Ikinyarwanda"},
  {"code": "ky", "name": "Kirghiz, Kyrgyz", "nativeName": "кыргыз тили"},
  {"code": "kv", "name": "Komi", "nativeName": "коми кыв"},
  {"code": "kg", "name": "Kongo", "nativeName": "KiKongo"},
  {"code": "ko", "name": "Korean", "nativeName": "한국어 (韓國語), 조선말 (朝鮮語)"},
  {"code": "kj", "name": "Kwanyama, Kuanyama", "nativeName": "Kuanyama"},
  {"code": "la", "name": "Latin", "nativeName": "latine, lingua latina"},
  {
    "code": "lb",
    "name": "Luxembourgish, Letzeburgesch",
    "nativeName": "Lëtzebuergesch"
  },
  {"code": "lg", "name": "Luganda", "nativeName": "Luganda"},
  {
    "code": "li",
    "name": "Limburgish, Limburgan, Limburger",
    "nativeName": "Limburgs"
  },
  {"code": "ln", "name": "Lingala", "nativeName": "Lingála"},
  {"code": "lo", "name": "Lao", "nativeName": "ພາສາລາວ"},
  {"code": "lt", "name": "Lithuanian", "nativeName": "lietuvių kalba"},
  {"code": "lu", "name": "Luba-Katanga", "nativeName": ""},
  {"code": "lv", "name": "Latvian", "nativeName": "latviešu valoda"},
  {"code": "gv", "name": "Manx", "nativeName": "Gaelg, Gailck"},
  {"code": "mk", "name": "Macedonian", "nativeName": "македонски јазик"},
  {"code": "mg", "name": "Malagasy", "nativeName": "Malagasy fiteny"},
  {"code": "ml", "name": "Malayalam", "nativeName": "മലയാളം"},
  {"code": "mt", "name": "Maltese", "nativeName": "Malti"},
  {"code": "mi", "name": "Māori", "nativeName": "te reo Māori"},
  {"code": "mr", "name": "Marathi (Marāṭhī)", "nativeName": "मराठी"},
  {"code": "mh", "name": "Marshallese", "nativeName": "Kajin M̧ajeļ"},
  {"code": "mn", "name": "Mongolian", "nativeName": "монгол"},
  {"code": "na", "name": "Nauru", "nativeName": "Ekakairũ Naoero"},
  {
    "code": "nv",
    "name": "Navajo, Navaho",
    "nativeName": "Diné bizaad, Dinékʼehǰí"
  },
  {"code": "nb", "name": "Norwegian Bokmål", "nativeName": "Norsk bokmål"},
  {"code": "nd", "name": "North Ndebele", "nativeName": "isiNdebele"},
  {"code": "ne", "name": "Nepali", "nativeName": "नेपाली"},
  {"code": "ng", "name": "Ndonga", "nativeName": "Owambo"},
  {"code": "nn", "name": "Norwegian Nynorsk", "nativeName": "Norsk nynorsk"},
  {"code": "no", "name": "Norwegian", "nativeName": "Norsk"},
  {"code": "ii", "name": "Nuosu", "nativeName": "ꆈꌠ꒿ Nuosuhxop"},
  {"code": "nr", "name": "South Ndebele", "nativeName": "isiNdebele"},
  {"code": "oc", "name": "Occitan", "nativeName": "Occitan"},
  {"code": "oj", "name": "Ojibwe, Ojibwa", "nativeName": "ᐊᓂᔑᓈᐯᒧᐎᓐ"},
  {
    "code": "cu",
    "name":
        "Old Church Slavonic, Church Slavic, Church Slavonic, Old Bulgarian, Old Slavonic",
    "nativeName": "ѩзыкъ словѣньскъ"
  },
  {"code": "om", "name": "Oromo", "nativeName": "Afaan Oromoo"},
  {"code": "or", "name": "Oriya", "nativeName": "ଓଡ଼ିଆ"},
  {"code": "os", "name": "Ossetian, Ossetic", "nativeName": "ирон æвзаг"},
  {"code": "pi", "name": "Pāli", "nativeName": "पाऴि"},
  {"code": "fa", "name": "Persian", "nativeName": "فارسی"},
  {"code": "pl", "name": "Polish", "nativeName": "polski"},
  {"code": "ps", "name": "Pashto, Pushto", "nativeName": "پښتو"},
  {"code": "pt", "name": "Portuguese", "nativeName": "Português"},
  {"code": "qu", "name": "Quechua", "nativeName": "Runa Simi, Kichwa"},
  {"code": "rm", "name": "Romansh", "nativeName": "rumantsch grischun"},
  {"code": "rn", "name": "Kirundi", "nativeName": "kiRundi"},
  {
    "code": "ro",
    "name": "Romanian, Moldavian, Moldovan",
    "nativeName": "română"
  },
  {"code": "ru", "name": "Russian", "nativeName": "русский язык"},
  {"code": "sc", "name": "Sardinian", "nativeName": "sardu"},
  {"code": "sd", "name": "Sindhi", "nativeName": "सिन्धी, سنڌي، سندھ"},
  {"code": "se", "name": "Northern Sami", "nativeName": "Davvisámegiella"},
  {"code": "sm", "name": "Samoan", "nativeName": "gagana faa Samoa"},
  {"code": "sg", "name": "Sango", "nativeName": "yângâ tî sängö"},
  {"code": "sr", "name": "Serbian", "nativeName": "српски језик"},
  {"code": "gd", "name": "Scottish Gaelic; Gaelic", "nativeName": "Gàidhlig"},
  {"code": "sn", "name": "Shona", "nativeName": "chiShona"},
  {"code": "si", "name": "Sinhala, Sinhalese", "nativeName": "සිංහල"},
  {"code": "sk", "name": "Slovak", "nativeName": "slovenčina"},
  {"code": "sl", "name": "Slovene", "nativeName": "slovenščina"},
  {"code": "so", "name": "Somali", "nativeName": "Soomaaliga, af Soomaali"},
  {"code": "st", "name": "Southern Sotho", "nativeName": "Sesotho"},
  {
    "code": "es",
    "name": "Spanish; Castilian",
    "nativeName": "español, castellano"
  },
  {"code": "su", "name": "Sundanese", "nativeName": "Basa Sunda"},
  {"code": "sw", "name": "Swahili", "nativeName": "Kiswahili"},
  {"code": "ss", "name": "Swati", "nativeName": "SiSwati"},
  {"code": "sv", "name": "Swedish", "nativeName": "svenska"},
  {"code": "ta", "name": "Tamil", "nativeName": "தமிழ்"},
  {"code": "te", "name": "Telugu", "nativeName": "తెలుగు"},
  {"code": "tg", "name": "Tajik", "nativeName": "тоҷикӣ, toğikī, تاجیکی‎"},
  {"code": "th", "name": "Thai", "nativeName": "ไทย"},
  {"code": "ti", "name": "Tigrinya", "nativeName": "ትግርኛ"},
  {
    "code": "bo",
    "name": "Tibetan Standard, Tibetan, Central",
    "nativeName": "བོད་ཡིག"
  },
  {"code": "tk", "name": "Turkmen", "nativeName": "Türkmen, Түркмен"},
  {
    "code": "tl",
    "name": "Tagalog",
    "nativeName": "Wikang Tagalog, ᜏᜒᜃᜅ᜔ ᜆᜄᜎᜓᜄ᜔"
  },
  {"code": "tn", "name": "Tswana", "nativeName": "Setswana"},
  {"code": "to", "name": "Tonga (Tonga Islands)", "nativeName": "faka Tonga"},
  {"code": "tr", "name": "Turkish", "nativeName": "Türkçe"},
  {"code": "ts", "name": "Tsonga", "nativeName": "Xitsonga"},
  {"code": "tw", "name": "Twi", "nativeName": "Twi"},
  {"code": "ty", "name": "Tahitian", "nativeName": "Reo Tahiti"},
  {"code": "uk", "name": "Ukrainian", "nativeName": "українська"},
  {"code": "ur", "name": "Urdu", "nativeName": "اردو"},
  {"code": "ve", "name": "Venda", "nativeName": "Tshivenḓa"},
  {"code": "vi", "name": "Vietnamese", "nativeName": "Tiếng Việt"},
  {"code": "vo", "name": "Volapük", "nativeName": "Volapük"},
  {"code": "wa", "name": "Walloon", "nativeName": "Walon"},
  {"code": "cy", "name": "Welsh", "nativeName": "Cymraeg"},
  {"code": "wo", "name": "Wolof", "nativeName": "Wollof"},
  {"code": "fy", "name": "Western Frisian", "nativeName": "Frysk"},
  {"code": "xh", "name": "Xhosa", "nativeName": "isiXhosa"},
  {"code": "yi", "name": "Yiddish", "nativeName": "ייִדיש"},
  {"code": "yo", "name": "Yoruba", "nativeName": "Yorùbá"},
  {
    "code": "za",
    "name": "Zhuang, Chuang",
    "nativeName": "Saɯ cueŋƅ, Saw cuengh"
  }
];
