import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/maintenance.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/repository/maintenance.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/maintance/maintenance.view.manutentor.dart';
import 'package:newhonekapp/app/routes/user/user_configuration.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';

class MaintanceMantutentore extends StatefulWidget {
  const MaintanceMantutentore({super.key});

  @override
  createState() => _MaintanceMantutentore();
}

class _MaintanceMantutentore extends State<MaintanceMantutentore> {
  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(Duration.zero);
      await getMaintenancesByMaintener();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentMaintenances,
        builder: (BuildContext context, value, Widget? child) {
          return Scaffold(
            bottomNavigationBar: AppBottomNavigation(pageActually: "maintance"),
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
                          "Maintenance",
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
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  currentMaintenances.value.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text("Non ci sono manutenzioni ative",
                              style: GoogleFonts.roboto(
                                fontSize: 18.0,
                                height: 1.5,
                                color: Color.fromARGB(255, 76, 79, 90),
                                fontWeight: FontWeight.w400,
                              )))
                      : Column(children: [
                          for (var item in currentMaintenances.value)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Card(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            item.reason.length > 16
                                                ? "${item.reason.substring(0, 16)}..."
                                                : item.reason,
                                            style: GoogleFonts.roboto(
                                              fontSize: 18.0,
                                              height: 1.5,
                                              color: Color.fromARGB(
                                                  255, 58, 59, 60),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Spacer(),
                                          InkWell(
                                              onTap: () => Helper.nextScreen(
                                                  context,
                                                  MaintenanceManutentoreView(
                                                      maintenance: item)),
                                              child: SizedBox(
                                                height: 20.0,
                                                width: 20.0,
                                                child: Icon(
                                                  Ionicons
                                                      .arrow_forward_outline,
                                                  size: 18,
                                                  color: Constants.primaryColor,
                                                ),
                                              )),
                                          SizedBox(height: 8),
                                        ],
                                      ))),
                            ),
                        ]),
                ],
              ),
            ),
          );
        });
  }
}
