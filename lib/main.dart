import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:newhonekapp/app/routes/chat/chats.dart';
import 'package:newhonekapp/app/routes/services/services.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/result.dart';
import 'package:newhonekapp/app/routes/user/configuration/billing.dart';
import 'package:newhonekapp/app/routes/user/configuration/billing.privato.dart';
import 'package:newhonekapp/app/routes/user/login.dart';
import 'package:newhonekapp/ui-kit/models/reservation_item.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/reservation_card.dart';
import 'app/routes/ loading.dart';
import 'app/routes/user/ blinkid/lang.dart';
import 'app/routes/user/ blinkid/scan_blink.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'dart:io';

// TODO: actualizar al subir

// ignore: non_constant_identifier_names
HideLocalNetwork() async {
  var deviceIp = await NetworkInfo().getWifiIP();
  Duration? timeOutDuration = Duration(milliseconds: 100);
  await Socket.connect(deviceIp ?? '', 80, timeout: timeOutDuration);
}

void main() async {
  //await dotenv.load(fileName: "assets/.env");
  //cameras = await availableCameras();
  runApp(MyApp());
  HideLocalNetwork();
        
  Stripe.merchantIdentifier = 'merchant.com.labicthonek.app';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (BuildContext buildContext, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Honek',
          theme: ThemeData(
            primaryColor: Constants.primaryColor,
            scaffoldBackgroundColor: Color.fromRGBO(252, 249, 245, 1),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.playfairDisplayTextTheme(),
          ),
          initialRoute: "/",
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }
}

// We need to make an onGenerateRoute function to handle routing

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        return LoadingPage();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return LoadingPage(); //To be created
      });
  }
}
