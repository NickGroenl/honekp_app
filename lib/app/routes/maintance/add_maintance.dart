import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/app/models/bookings/bookings.dart';
import 'package:newhonekapp/app/models/maintenance.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/maintenance.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';
import '../../../ui-kit/widgets/forms/dropdown.dart';
// ignore: depend_on_referenced_packages

class AddMaintance extends StatefulWidget {
  const AddMaintance({super.key});

  @override
  createState() => _AddMaintance();
}

class _AddMaintance extends State<AddMaintance> {
  late int indexBooking = -1;
  late int indexMaintaner;
  late String stateMessage = "";
  late int priority = 0;
  List<UserModel> maintenerss = [];

  final translator = GoogleTranslator();
  String low = 'Bassa';
  String medium = "Media";
  String long = "Alta";
  String urgently = "Urgente";
  String room = 'Camera';

  String maintener = 'Manutentore';
  String prioritys = 'Priorita';
  String motive = 'Motivo';
  String note = 'Nota';
  String aggiungiMaintener = 'Hai aggiunto una manutenzione.';
  String aggiungiError = 'Se a verificato un error';
  String aggiungiErrorAll = 'Seleziona tutti i campi';
  String save = 'Salva';
  getTransalations(String lang) async {
    var lowCast = await translator.translate(low, from: 'it', to: lang);
    var mediumCast = await translator.translate(medium, from: 'it', to: lang);
    var longCast = await translator.translate(long, from: 'it', to: lang);
    var urgentlyCast =
        await translator.translate(urgently, from: 'it', to: lang);
    var maintenerCast =
        await translator.translate(maintener, from: 'it', to: lang);
    var priorityCast =
        await translator.translate(prioritys, from: 'it', to: lang);
    var motiveCast = await translator.translate(motive, from: 'it', to: lang);
    var noteCast = await translator.translate(note, from: 'it', to: lang);
    var aggiungiMaintenerCast =
        await translator.translate(aggiungiMaintener, from: 'it', to: lang);
    var aggiungiErrorCast =
        await translator.translate(aggiungiError, from: 'it', to: lang);
    var aggiungiErrorAllCast =
        await translator.translate(aggiungiErrorAll, from: 'it', to: lang);
    var saveCast = await translator.translate(save, from: 'it', to: lang);

    setState(() {
      low = lowCast.text;
      medium = mediumCast.text;
      long = longCast.text;
      urgently = urgentlyCast.text;
      maintener = maintenerCast.text;
      prioritys = priorityCast.text;
      motive = motiveCast.text;
      note = noteCast.text;
      aggiungiMaintener = aggiungiMaintenerCast.text;
      aggiungiError = aggiungiErrorCast.text;
      aggiungiErrorAll = aggiungiErrorAllCast.text;
      save = saveCast.text;
    });

    return false;
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'motive': FormControl<String>(
          validators: [Validators.required, Validators.minLength(3)],
        ),
        'note': FormControl<String>(
          validators: [Validators.required, Validators.minLength(3)],
        ),
      });
  late FocusNode _focusNode;
  //late CameraDescription camera;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
    //camera = (await availableCameras()) as CameraDescription;
    int tmpIndex = currentBooking.value.isNotEmpty ? 0 : -1;
    settingIndex(tmpIndex);
    setState(() {
      indexBooking = currentBooking.value.isNotEmpty ? 0 : -1;
      indexMaintaner = currentMainteners.value.isNotEmpty ? 0 : -1;
    });
    getTransalations(currentUser.value.default_language);
  }

  void settingIndex(int index) {
    List<UserModel> rssss = [];
    if (currentBooking.value.isNotEmpty && index != -1) {
      for (var i = 0; i < currentMainteners.value.length; i++) {
        if (currentBooking.value[index].author_id ==
            currentMainteners.value[i].parentId) {
          rssss.add(currentMainteners.value[i]);
        }
      }
      setState(() {
        maintenerss = rssss;
      });
    }
  }

  void getPriority(String value) {
    int pr = 0;
    if (value == low) {
      pr = 0;
    } else if (value == medium) {
      pr = 1;
    } else if (value == long) {
      pr = 2;
    } else if (value == urgently) {
      pr = 3;
    }

    setState(() {
      priority = pr;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: buildForm,
      builder: (BuildContext context, FormGroup formGroup, Widget? child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(bottom: false, child: SizedBox()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      BackButton(),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      room,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    AppDropdownInput(
                                      hintText: room,
                                      options: currentBooking.value
                                          .map((e) => e.name_structure)
                                          .toList(),
                                      value: '${currentBooking
                                          .value[0].name_structure}(${currentBooking.value[0].namber_room})',
                                      getLabel: (String value) => value,
                                      onChanged: (value) => {
                                        currentBooking.value.map((e) => {
                                              if (e.name_structure == value)
                                                {
                                                  setState(() {
                                                    indexBooking =
                                                        currentBooking.value
                                                            .indexOf(e);
                                                  }),
                                                  settingIndex(currentBooking
                                                      .value
                                                      .indexOf(e))
                                                }
                                            })
                                      },
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      maintener,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    AppDropdownInput(
                                        hintText: maintener,
                                        options: maintenerss.isNotEmpty
                                            ? maintenerss
                                                .map((e) =>
                                                    "${e.name} ${e.lastname}")
                                                .toList()
                                            : [''],
                                        value: maintenerss.isNotEmpty
                                            ? "${maintenerss[0].name} ${maintenerss[0].lastname}"
                                            : '',
                                        getLabel: (String value) => value,
                                        onChanged: (value) => {
                                              maintenerss.map((e) => {
                                                    if ("${e.name} ${e.lastname}" ==
                                                        value!)
                                                      {
                                                        setState(() {
                                                          indexMaintaner =
                                                              maintenerss
                                                                  .indexOf(e);
                                                        }),
                                                      }
                                                  })
                                            }),
                                    SizedBox(height: 15.0),
                                    Text(
                                      prioritys,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    AppDropdownInput(
                                      hintText: prioritys,
                                      options: [low, medium, long, urgently],
                                      value: low,
                                      getLabel: (String value) => value,
                                      onChanged: (value) =>
                                          {getPriority(value!)},
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      motive,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveTextField<String>(
                                      formControlName: 'motive',
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: '',
                                        helperText: '',
                                        counterText: "",
                                        helperStyle: TextStyle(height: 0.7),
                                        errorStyle: TextStyle(height: 0.7),
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      note,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveTextField<String>(
                                      formControlName: 'note',
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        labelText: '',
                                        helperText: '',
                                        counterText: "",
                                        helperStyle: TextStyle(height: 0.7),
                                        errorStyle: TextStyle(height: 0.7),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      stateMessage,
                                      style: GoogleFonts.roboto(
                                        fontSize: 18.0,
                                        color: Color.fromARGB(255, 85, 86, 85),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    PrimaryButton(
                                      onPressed: () async => {
                                        if (formGroup.valid)
                                          {
                                            if (indexBooking != -1 &&
                                                indexMaintaner != -1)
                                              {
                                                if (await addMaintenance({
                                                  "room_id": currentBooking
                                                      .value[indexBooking]
                                                      .id_room,
                                                  "user_id": maintenerss[
                                                          indexMaintaner]
                                                      .id,
                                                  "status": "request",
                                                  "priority": 1,
                                                  "reason":
                                                      formGroup.value['motive'],
                                                  "notes":
                                                      formGroup.value['note']
                                                }))
                                                  {
                                                    setState(() {
                                                      stateMessage =
                                                          aggiungiMaintener;
                                                    })
                                                  }
                                                else
                                                  setState(() {
                                                    stateMessage =
                                                        aggiungiError;
                                                  })
                                              }
                                            else
                                              {
                                                setState(() {
                                                  stateMessage =
                                                      aggiungiErrorAll;
                                                })
                                              }
                                          }
                                        else
                                          {formGroup.markAllAsTouched()}
                                      },
                                      text: save,
                                    ),
                                    SizedBox(
                                      height: 25.0,
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
          ),
        );
      },
    );
  }
}
