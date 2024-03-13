import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/maintenance.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/maintenance.dart';
import 'package:newhonekapp/app/routes/maintance/maintenance.gob.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/forms/input.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';

class MaintenanceGobernanteView extends StatefulWidget {
  final MaintenancesModel maintenance;
  const MaintenanceGobernanteView({super.key, required this.maintenance});
  @override
  createState() => _MaintenanceGobernanteView();
}

class _MaintenanceGobernanteView extends State<MaintenanceGobernanteView> {
  late String priority = '';
  late String status = widget.maintenance.status;
  late String notes = widget.maintenance.notes;

  final translator = GoogleTranslator();
  String low = 'Bassa';
  String medium = "Media";
  String long = "Alta";
  String urgently = "Urgente";
  String aggiorna = 'Aggiorna manutenzione';
  String change = "Clicca per cambiare";

  getTranslations(String lang) async {
    var lowCast = await translator.translate(low, from: 'it', to: lang);
    var mediumCast = await translator.translate(medium, from: 'it', to: lang);
    var longCast = await translator.translate(long, from: 'it', to: lang);
    var urgentlyCast =
        await translator.translate(urgently, from: 'it', to: lang);
    var aggiornaCast =
        await translator.translate(aggiorna, from: 'it', to: lang);
    var changeCast = await translator.translate(change, from: 'it', to: lang);

    setState(() {
      low = lowCast.text;
      medium = mediumCast.text;
      long = longCast.text;
      urgently = urgentlyCast.text;
      aggiorna = aggiornaCast.text;
      change = changeCast.text;
    });

    return false;
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'notes': FormControl<String>(
          validators: [Validators.required],
        ),
      });
  String getStatusToChange() {
    switch (status) {
      case "request":
        return 'working';
      case "working":
        return 'closed';
      case "closed":
        return 'request';
    }
    return '';
  }

  Color? getColorFromStatus() {
    switch (status) {
      case "request":
        return Color.fromARGB(255, 84, 139, 181);
      case "working":
        return Color.fromARGB(255, 173, 182, 10);
      case "closed":
        return Color.fromARGB(255, 189, 61, 67);
    }
    return Color.fromARGB(255, 189, 61, 67);
  }

  @override
  void initState() {
    super.initState();
    getTranslations(currentUser.value.default_language);
    // ignore: use_build_context_synchronously

    switch (widget.maintenance.priority) {
      case 0:
        priority = low;
        break;
      case 1:
        priority = medium;
        break;
      case 2:
        priority = long;
        break;
      case 3:
        priority = urgently;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ReactiveFormBuilder(
      builder: (BuildContext context, FormGroup formGroup, Widget? child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(bottom: false, child: SizedBox()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      onPressed: () async => {
                        await getMaintenancesByGobernante(
                            currentUser.value.parentId),
                        Helper.nextScreen(context, MaintenanceGobernante())
                      },
                    ),
                    Spacer(),
                    Text(
                      aggiorna,
                      style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        height: 1.5,
                        color: Color.fromARGB(255, 71, 80, 106),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color.fromARGB(0, 244, 245, 246),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Ionicons.key_outline,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        widget.maintenance.room_name,
                                        style: GoogleFonts.roboto(
                                          fontSize: 20.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Ionicons.alert_circle_outline,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        priority,
                                        style: GoogleFonts.roboto(
                                          fontSize: 20.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Ionicons.hand_left_outline,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          widget.maintenance.reason,
                                          style: GoogleFonts.roboto(
                                            fontSize: 20.0,
                                            color: Color.fromRGBO(
                                                138, 150, 191, 1),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.clip,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20.0),
                                  ReactiveTextField<String>(
                                    formControlName: 'notes',
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelStyle: GoogleFonts.roboto(),
                                      suffix: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          onPressed: (() async {
                                            if (formGroup.valid) {
                                              // ignore: avoid_print
                                              if (await updateMaintenanceNotes({
                                                "id": widget.maintenance.id,
                                                "notes":
                                                    formGroup.value['notes']
                                              })) {
                                                setState(() {
                                                  notes = formGroup
                                                      .value['notes']
                                                      .toString();
                                                });
                                                await getMaintenancesByGobernante(
                                                    currentUser.value.authorid);
                                              }
                                            } else {
                                              formGroup.markAllAsTouched();
                                            }
                                          }),
                                          child: Icon(Ionicons.checkmark)),
                                      labelText: notes,
                                      helperText: '',
                                      helperStyle: TextStyle(height: 0.7),
                                      errorStyle: TextStyle(height: 0.7),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async => {
                                      if (await updateMaintenanceStatus({
                                        "id": widget.maintenance.id,
                                        "status": getStatusToChange()
                                      }))
                                        {
                                          setState(
                                            () {
                                              status = getStatusToChange();
                                            },
                                          ),
                                          getMaintenancesByMaintener()
                                        }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: getColorFromStatus(),
                                    ),
                                    child: Text(
                                      '$change (${status.toUpperCase()})',
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromARGB(255, 42, 44, 49),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
      form: buildForm,
    ));
  }
}
