import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';
import 'package:cache_manager/core/read_cache_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart'
    show EventChannel, PlatformException, rootBundle;
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_face_api/face_api.dart' as Regula;
import 'package:newhonekapp/app/routes/user/configuration/billing.privato.dart';

import '../../../../ui-kit/utils/helper.dart';
import '../../../repository/user.dart';
import 'result2.dart';


class BlinkInit extends StatefulWidget {
  const BlinkInit({super.key});

  @override
  createState() => _BlinkInit();
}

class _BlinkInit extends State<BlinkInit> {
  var image1 = new Regula.MatchFacesImage();
  var image2 = new Regula.MatchFacesImage();
  bool isReadingRfidCustomUi = false;
  bool isReadingRfid = false;
  String rfidUIHeader = "Reading RFID";
  Color rfidUIHeaderColor = Colors.black;
  String rfidDescription = "Place your phone on top of the NFC tag";
  double rfidProgress = -1;
  bool _canRfid = false;
  bool _doRfid = false;

  dynamic resultDocument;
  dynamic resultMatch;
  var printError =
      (Object error) => print((error as PlatformException).message);

  @override
  void initState() {
      
    super.initState();
    initPlatformState();
    const EventChannel('flutter_document_reader_api/event/completion')
        .receiveBroadcastStream()
        .listen((jsonString) => handleCompletion(
            DocumentReaderCompletion.fromJson(json.decode(jsonString))!));
    const EventChannel('flutter_document_reader_api/event/database_progress')
        .receiveBroadcastStream()
        .listen((progress) => print("Downloading database: $progress%"));
    const EventChannel(
            'flutter_document_reader_api/event/rfid_notification_completion')
        .receiveBroadcastStream()
        .listen((event) =>
            print("rfid_notification_completion: ${event.toString()}"));
    const EventChannel('flutter_face_api/event/video_encoder_completion')
        .receiveBroadcastStream()
        .listen((event) {
      var response = jsonDecode(event);
      String transactionId = response["transactionId"];
      bool success = response["success"];
      print("video_encoder_completion:");
      print("    success: $success");
      print("    transactionId: $transactionId");
    });
  }

  setImage(bool first, Uint8List? imageFile, int type) {
      if (imageFile == null) return;
      if (first) {
        image1.bitmap = base64Encode(imageFile);
        image1.imageType = type;
        
      } else {
        image2.bitmap = base64Encode(imageFile);
        image2.imageType = type;
      }
  }
  initMatch(DocumentReaderResults results) async {
    await Regula.FaceSDK.init().then((json) {
      var response = jsonDecode(json);
      if (!response["success"]) {
        print("Init failed: ");
        print(json);
      }
    });
    
    Regula.FaceSDK.setServiceUrl('https://faceapi.regulaforensics.com');
    Regula.FaceSDK.startLiveness().then((value) {
        var result = Regula.LivenessResponse.fromJson(json.decode(value));
        setImage(true, base64Decode(result!.bitmap!.replaceAll("\n", "")),
            Regula.ImageType.LIVE);
        matchFaces(results);
    });
    
      
    
  }
  matchFaces(DocumentReaderResults results) async {
    if (image1.bitmap == null ||
        image1.bitmap == "" ||
        image2.bitmap == null ||
        image2.bitmap == "") return;
  

    var name = await results
        .textFieldValueByType(EVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES);
          print('2');
    var namesSplit = name?.split(' ');

    var doc = await results
        .graphicFieldImageByType(EGraphicFieldType.GF_DOCUMENT_IMAGE);
    var back = await results.graphicFieldImageByType(208);
    
    var backImage = null;
    for(var field in results.graphicResult!.fields){
        
        if(field!.pageIndex == 1 && field.fieldName == 'Document image'){
          print('hola imagencita');
          backImage = field.value;
        }
        //print(field.value);
    }
    
    var portrait = await results.graphicFieldImageByType(EGraphicFieldType.GF_PORTRAIT);
    var request = Regula.MatchFacesRequest();
    request.images = [image1, image2];
    var map = <String, dynamic>{};
    map['name'] = namesSplit!.isNotEmpty ? namesSplit[1] : 'Non definito';
    map['lastname'] = namesSplit.isNotEmpty ? namesSplit[0] : 'Non definito';
    map['address'] = results != null ? await results.textFieldValueByType(EVisualFieldType.FT_ADDRESS) : 'Non Definito';
    map['birth'] = results != null ?  await results.textFieldValueByType(EVisualFieldType.FT_DATE_OF_BIRTH) : 'Non Definito';
    map['gender'] =  results != null ?  await results.textFieldValueByType(EVisualFieldType.FT_SEX) : 'M';
    map['image'] = base64Encode(List<int>.from(portrait!.data!.contentAsBytes()));
    map['number_document'] = results != null ?  await results.textFieldValueByType(EVisualFieldType.FT_DOCUMENT_NUMBER) : 'Non Definito';
    map['expired_document'] = results != null ?  await results.textFieldValueByType(EVisualFieldType.FT_DATE_OF_EXPIRY) : 'Non Definito';
    if(backImage != null) {
      map['back_image'] = backImage;
    } else {
      map['back_image'] = base64Encode(List<int>.from(doc!.data!.contentAsBytes()));
    }
    map['front_image'] = base64Encode(List<int>.from(doc!.data!.contentAsBytes()));
    map['placebirth'] = results != null ?  await results.textFieldValueByType(EVisualFieldType.FT_PLACE_OF_BIRTH) : 'Non Definito';
    await Regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) async {
    var response = Regula.MatchFacesResponse.fromJson(json.decode(value));
    await Regula.FaceSDK.matchFacesSimilarityThresholdSplit(
              jsonEncode(response!.results), 0.75)
          .then((str) async {
        var split = Regula.MatchFacesSimilarityThresholdSplit.fromJson(
            json.decode(str));
        setState(() {
          resultMatch = split?.matchedFaces;
        });
        print(split);
        if(split!.matchedFaces.isNotEmpty){
          if(await scanToDataBase(map)){
            // ignore: use_build_context_synchronously
            Helper.nextScreen(
                                    context,
                                    BillingPrivato(
                                      steps: true,
                                      scanningManual: false,
                                    ));
          }
         
            
          

          
        }
      });
    });

  }
  void handleCompletion(DocumentReaderCompletion completion) {
    if (isReadingRfidCustomUi &&
        (completion.action == DocReaderAction.CANCEL ||
            completion.action == DocReaderAction.ERROR)) this.hideRfidUI();
    if (isReadingRfidCustomUi &&
        completion.action == DocReaderAction.NOTIFICATION) {
      updateRfidUI(completion.results!.documentReaderNotification);
    }
    if (completion.action ==
        // ignore: curly_braces_in_flow_control_structures
        DocReaderAction.COMPLETE) if (isReadingRfidCustomUi) {
          if (completion
            .results!.rfidResult !=
        1) {
            restartRfidUI();
          } else {
      hideRfidUI();
      displayResults(completion.results!);
    }
        } else {
          handleResults(completion.results!);
        }
    if (completion.action == DocReaderAction.TIMEOUT) {
      handleResults(completion.results!);
    }
  }

  void showRfidUI() {
    // show animation
    setState(() => isReadingRfidCustomUi = true);
  }

  hideRfidUI() {
    // show animation
    restartRfidUI();
    DocumentReader.stopRFIDReader();
    setState(() {
      isReadingRfidCustomUi = false;
      rfidUIHeader = "Reading RFID";
      rfidUIHeaderColor = Colors.black;
    });
  }

  restartRfidUI() {
    setState(() {
      rfidUIHeaderColor = Colors.red;
      rfidUIHeader = "Failed!";
      rfidDescription = "Place your phone on top of the NFC tag";
      rfidProgress = -1;
    });
  }

  updateRfidUI(results) {
    if (results.code ==
        ERFIDNotificationCodes.RFID_NOTIFICATION_PCSC_READING_DATAGROUP) {
      //setState(() => rfidDescription =
          //ERFIDDataFileType.getTranslation(results.dataFileType));
    }
    setState(() {
      rfidUIHeader = "Reading RFID";
      rfidUIHeaderColor = Colors.black;
      rfidProgress = results.value / 100;
    });
    if (Platform.isIOS) {
      DocumentReader.setRfidSessionStatus(
          "$rfidDescription\n${results.value.toString()}%");
    }
  }

  customRFID() {
    showRfidUI();
    DocumentReader.readRFID();
  }

  usualRFID() {
    isReadingRfid = true;
    DocumentReader.startRFIDReader();
  }

  Future<void> initPlatformState() async {
    print(await DocumentReader.prepareDatabase("Full"));
    ByteData byteData = await rootBundle.load("assets/regula.license");
    print(await DocumentReader.initializeReader({
      "license": base64.encode(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)),
      "delayedNNLoad": true
    }));
    bool canRfid = await DocumentReader.isRFIDAvailableForUse();
    setState(() => _canRfid = canRfid);
var scenariosTemp =
        json.decode(await DocumentReader.getAvailableScenarios());
    for (var i = 0; i < scenariosTemp.length; i++) {
      DocumentReaderScenario scenario = DocumentReaderScenario.fromJson(
          scenariosTemp[i] is String
              ? json.decode(scenariosTemp[i])
              : scenariosTemp[i])!;
              print(scenario.name);
    }    DocumentReader.setConfig({
      "functionality": {
        "videoCaptureMotionControl": true,
        "showCaptureButton": true
      },
      "customization": {
        "showResultStatusMessages": true,
        "showStatusMessages": true
      },
      "processParams": {"scenario": 'FullProcess', 'multipageProcessing' : true}
    });
    DocumentReader.setRfidDelegate(RFIDDelegate.NO_PA);
    var result = await DocumentReader.showScanner();
    print(result);
  }

  displayResults(DocumentReaderResults results) async {
    var back =
        await results.graphicFieldImageByType(208);
    var portrait =
        await results.graphicFieldImageByType(EGraphicFieldType.GF_PORTRAIT);
    if (portrait != null) {
      setState(() {
        resultDocument = results;
      });
      setImage(false, portrait.data!.contentAsBytes(), Regula.ImageType.PRINTED);
      
      initMatch(results);
    }
  }

  void handleResults(DocumentReaderResults results) {
    if (_doRfid && !isReadingRfid && results.chipPage != 0) {
      // customRFID();
      usualRFID();
    } else {
      isReadingRfid = false;
      displayResults(results);
    }
  }

  void onChangeRfid(bool? value) {
    setState(() => _doRfid = value! && _canRfid);
    DocumentReader.setConfig({
      "processParams": {"doRfid": _doRfid}
    });
  }

  
 


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: const <
              Widget>[
                Text('Loading')
            
          ])),
    );
  }
}