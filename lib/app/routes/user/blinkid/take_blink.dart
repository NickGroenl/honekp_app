// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/user.dart';
import 'package:newhonekapp/app/routes/%20loading.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/insert_dates.dart';
import 'package:newhonekapp/app/routes/user/configuration/billing.dart';
import 'package:newhonekapp/app/routes/user/configuration/billing.privato.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:translator/translator.dart';

import '../../../../ui-kit/utils/constants.dart';

class TakePictureScreen extends StatefulWidget {
  final String lang;

  const TakePictureScreen({super.key, required this.lang});
  @override
  State<StatefulWidget> createState() {
    return _TakePictureScreen();
  }
}

class _TakePictureScreen extends State<TakePictureScreen> {
  XFile? imageFile;
  XFile? imageFileBack;
  final ImagePicker _picker = ImagePicker();
  String backFoto = "Procedura offline documenti cartacei";
  String backFoto2 = "Foto della parte anteriore del documento";
  String frontPhoto = "Foto sul retro del documento";
  String next = "Avanti";

  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var backFotoCast =
        await translator.translate(backFoto, from: 'it', to: lang);
    var frontPhotoCast =
        await translator.translate(frontPhoto, from: 'it', to: lang);
    var backFoto2Cast =
        await translator.translate(backFoto2, from: 'it', to: lang);
    var nextCast = await translator.translate(next, from: 'it', to: lang);
    setState(() {
      backFoto = backFotoCast.text;
      backFoto2 = backFoto2Cast.text;
      frontPhoto = frontPhotoCast.text;
      next = nextCast.text;
    });

    return false;
  }

  _openCameraFront() async {
    XFile? castFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        maxWidth: 300,
        maxHeight: 300);
    imageFile = castFile;
    setState(() {});
    imageCache.clearLiveImages();
  }

  _openCameraBack() async {
    XFile? castFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        maxWidth: 300,
        maxHeight: 300);
    imageFileBack = castFile;
    setState(() {});
    imageCache.clearLiveImages();
  }

  @override
  void initState() {
    super.initState();
    getTranslations(widget.lang != '' ? widget.lang : 'en');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 35.0, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:  [
            Center(
              child: PrimaryButton(
                  text: next,
                  onPressed: () async => {
                        if (imageFile != null && imageFileBack != null)
                          {
                            if (await scanToDataBase
                            ({
                              "name": 'nulling',
                              "lastname": 'nulling',
                              "address": 'nulling',
                              "birth": 'nulling',
                              "gender": 'M',
                              "image": base64Encode(
                                  await imageFileBack!.readAsBytes()),
                              "number_document": 'nulling',
                              "expired_document": 'nulling',
                              "back_image": base64Encode(
                                  await imageFileBack!.readAsBytes()),
                              "front_image":
                                  base64Encode(await imageFile!.readAsBytes()),
                              "placebirth": 'nulling'
                            }))
                              {
                                Helper.nextScreen(
                                    context,
                                    BillingPrivato(
                                      steps: true,
                                      scanningManual: false,
                                    ))
                              }
                          }
                      }),
            ) ])
      ),
        body: SafeArea(
      top: true,
      bottom: true,
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  // ...

                  DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.all(9),
                        child: Text(
                          "1",
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
                            color: Constants.primaryColor,
                            width: 2,
                          ),
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.all(9),
                        child: Text(
                          "2",
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
                        padding: EdgeInsets.all(9),
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
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),  child: Text(
                      backFoto,
                      style: GoogleFonts.roboto(
                        fontSize: 25.0,
                        height: 1.5,
                        color: Color.fromARGB(255, 45, 46, 50),
                        fontWeight: FontWeight.w600,
                      ),
                    ),),
            Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.2,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: imageFile != null
                            ? FileImage(File(imageFile!.path))
                            : NetworkImage('') as ImageProvider,
                        fit: BoxFit.cover))),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: () async {
                  await _openCameraFront();
                },
                child: Text(backFoto2)),
            Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.2,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: imageFileBack != null
                            ? FileImage(File(imageFileBack!.path))
                            : NetworkImage('') as ImageProvider,
                        fit: BoxFit.cover))),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: () async {
                  await _openCameraBack();
                },
                child: Text(frontPhoto)),
            
            
          ],
        ),
      ),
    ));
  }

  //********************** IMAGE PICKER

  // Image picker
}
