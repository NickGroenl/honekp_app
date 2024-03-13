import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/keeping.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/repository/keeping.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/booking.admin.card.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/keeping_card.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../user/user_configuration.dart';

class CamareraKeepings extends StatefulWidget {
  const CamareraKeepings({super.key});

  @override
  createState() => _CamareraKeepings();
}

class _CamareraKeepings extends State<CamareraKeepings> {
  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(Duration.zero);
      // ignore: use_build_context_synchronously
      await getKeepings();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(pageActually: "bookings"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                  ),
                  Text(
                    "Housekeeping",
                    style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      height: 1.5,
                      color: Color.fromARGB(255, 71, 80, 106),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                      onTap: () =>
                          Helper.nextScreen(context, UserConfiguration()),
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    currentUser.value.image != ''
                                        ? "$baseUrl/${currentUser.value.image}"
                                        : ''),
                                fit: BoxFit.cover),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0)
                            ]),
                      )),
                ],
              ),
            ),
            
            SizedBox(
              height: 30.0,
            ),
            ValueListenableBuilder(
              valueListenable: currentKeepings,
              builder: (BuildContext context, value, Widget? child) {
                return currentKeepings.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "Non abbiamo trovato keepings",
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 76, 79, 90),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            if (currentKeepings.value.isNotEmpty)
                              for(var item in currentKeepings.value)
                              KeepingCamera(checked: item.checked == 1 ? true : false, room_name: item.room_name, position: item.position, status: item.status, id: item.id,)
                          ],
                        ),
                      );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
