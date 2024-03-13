// ignore_for_file: avoid_print
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/bookings/room.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/repository/rooms.dart';
import 'package:newhonekapp/app/routes/user/user_configuration.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/room_card.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../ui-kit/utils/helper.dart';

class DashBoardOpeenDoor extends StatefulWidget {
  const DashBoardOpeenDoor({super.key});
  @override
  createState() => _DashBoardOpeenDoor();
}

class _DashBoardOpeenDoor extends State<DashBoardOpeenDoor> {
  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(Duration.zero);
      // ignore: use_build_context_synchronously
      await getOpenDoorRooms(currentUser.value.parentId);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(
        pageActually: "home",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image(
                      semanticLabel: "assets/images/logo.png",
                      image: AssetImage("assets/images/logo.png"),
                      width: 90,
                      height: 38,
                    ),
                  ),
                  ValueListenableBuilder(
                    builder: (BuildContext context, value, Widget? child) {
                      return InkWell(
                          onTap: () =>
                              Helper.nextScreen(context, UserConfiguration()),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(currentUser
                                                .value.image !=
                                            ''
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
                          ));
                    },
                    valueListenable: currentUser,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Open door system",
                style: GoogleFonts.roboto(
                  fontSize: 26.0,
                  height: 1.5,
                  color: Color.fromARGB(255, 71, 80, 106),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            ValueListenableBuilder(
              valueListenable: currentRooms,
              builder: (BuildContext context, value, Widget? child) {
                return (Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      for (var item in currentRooms.value)
                        RoomCard(
                          ip: item.ip,
                          name: item.name,
                        )
                    ],
                  ),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
