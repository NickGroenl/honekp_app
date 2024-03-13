/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:identity_verification_flutter/identity_verification.dart';


const String androidLicenseFileName =
    'license.key';
const String iosLicense =
    'sRwAAAETY29tLmxhYmljdGhvbmVrLmFwcMWqQ4MaSq8gfJCioiunRNldMtufBIiuG85pNGoqLpTO3wnN5tcaeVy2vHADEYiK65k6tc6/EoA15UGBrFl/JFGjnOSpIQ2hdfwCvQFg2LzM0Ypav3RgKtFE1c5NpGChz3u5eV5/JUTX2fEGv/Ek/Z1Mhn/Ruowwn9UY8kmOaRvjsOrKVgRP/NDdSzRgPusMc2Dh8tN2QZrDBg0QnOJGh8gZhj2HYqvmdUMf61sN0y96';

class CameraBlink extends StatefulWidget {
  const CameraBlink({Key? key}) : super(key: key);

  @override
  State<CameraBlink> createState() => _CameraBlink();
}

class _CameraBlink extends State<CameraBlink> {
  final idv = IdentityVerification();
  IdvResult? idvResult;
  IdvError? error;

  @override
  void initState() {
    super.initState();
  }

  final List<String> fields = [





    FieldLastName(
        modificationConfig: ModificationConfig(
            editable: true,
            insertable: true,
            validators: [MinLength(intValue: 3)])),
    FieldFirstName(
        modificationConfig: ModificationConfig(
            validators: [Required()], editable: true, insertable: false)),
    FieldAdditionalNameInformation(),
    FieldRace(),
    FieldSex(),
    FieldDateOfExpiry(),
    FieldDateOfExpiryPermanent(),
    FieldIssuingAuthority(),
    FieldDateOfBirth(),
    FieldDocumentNumber(
        modificationConfig:
            ModificationConfig(insertable: true, editable: false))
  ];

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<dynamic> startVerification() async {
    final verificationServiceSettings = VerificationServiceSettings(
        url: 'https://api.idv.microblink.com');

    final livenessStep =
        LivenessStep(liveness: Liveness.IProov, initializeInProduction: true);

    final scanSteps = DocumentScanStep(scanStep: ScanStep.BlinkId)
      ..androidLicenseFileName = androidLicenseFileName
      ..iOSLicense = iosLicense
      ..attachDocumentListener = true
      ..showDocumentImages = true
      ..showResultHeader = true
      ..documentFields = fields;

    final idvConfig = IdvConfiguration(
      scanStep: scanSteps,
      verificationServiceSettings: verificationServiceSettings,
      disableScreenshots: true,
      livenessStep: livenessStep,
    );

    final result = await idv.startVerification(idvConfig);

    return result;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Identity Verification Sample App'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 31,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (idvResult != null) {
                    final List<Widget> fields = [];

                    fields.add(const Text(
                      'Identity Verification Result',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ));

                    if (idvResult?.livenessImage != null) {
                      fields.add(const Text(
                        'Face: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ));
                      fields.add(Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                            height: 255,
                            child: idvResult!.livenessImage!,
                          )),
                          Expanded(
                              child: Container(
                            height: 255,
                            child: idvResult!.faceImage!,
                          )),
                        ],
                      ));
                    }

                    if (idvResult?.frontSideDocumentImage != null) {
                      fields.add(const Text(
                        'Front Side Document: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ));
                      fields.add(idvResult!.frontSideDocumentImage!);
                    }

                    if (idvResult?.backSideDocumentImage != null) {
                      fields.add(const Text(
                        'Back Side Document: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ));
                      fields.add(idvResult!.backSideDocumentImage!);
                    }

                    if (idvResult?.signatureImage != null) {
                      fields.add(idvResult!.signatureImage!);
                    }

                    fields.add(const Text(
                      'Fields: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ));

                    idvResult!.getResultFieldAsMap().forEach((key, value) {
                      fields.add(Text(
                          "${key.name.replaceAll('_', ' ')}: ${value.getDisplayString().replaceAll('\n', ' ')}"));
                    });

                    if (kDebugMode) {
                      print(idvResult!.classInfo?.country);
                      print(idvResult!.classInfo?.region);
                      print(idvResult!.classInfo?.type);
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: fields,
                      ),
                    );
                  } else if (error != null) {
                    return Text("${error?.toString()}");
                  }

                  return Container();
                },
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      final result = await startVerification();
                      setState(() {
                        if (result is IdvResult) {
                          error = null;
                          idvResult = result;
                        } else {
                          idvResult = null;
                          error = result;
                        }
                      });
                    },
                    child: const Text('Start Verification')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setupThemeCustomization() {
    // final colorTheme = ColorTheme()
    //   ..primaryColor = Colors.red
    //   ..labelColor = Colors.blue;

    final colorTheme = IdvColorTheme()
      ..stepCaptionColor = IdvColor(color: '#ff0000')
      ..labelColor = IdvColor(color: '804948', darkModeColor: '#B3E0E7');

    final imageTheme = IdvImageTheme()
      ..landingIllustration = 'assets/MyCustomImage.png'
      ..faceTecIconClose = 'assets/sample.png';

    final fontTheme = IdvFontTheme()
      ..navigationBarTitleFont =
          IdvFont(size: 24, weight: FontWeight.w900.index)
      ..fontFamily =
          IdvFontFamily(name: 'Spartan', path: 'assets/Spartan-Bold.ttf');

    final viewTheme = IdvViewTheme()..buttonCornerRadius = 20;

    final navTheme = IdvNavigationTheme()
      ..barStyle = BarStyle.black
      ..isTranslucent = false
      ..titleColor = '#ff0000'
      ..barTintColor = '#ff0000';

    final localizationTheme = IdvLocalizationTheme()
      ..localizationFileName = 'IDVLocalizable';

    final dateTheme = IdvDateFormatterTheme()..customDateFormat = 'MM/dd/yyyy';

    idv.setupThemes(
        colorTheme: colorTheme,
        fontTheme: fontTheme,
        imageTheme: imageTheme,
        localizationTheme: localizationTheme,
        viewTheme: viewTheme,
        navigationTheme: navTheme,
        dateFormatterTheme: dateTheme);
    // Idv().setupThemes(colorTheme: colorTheme.toIdvColorTheme());
  }
}
*/