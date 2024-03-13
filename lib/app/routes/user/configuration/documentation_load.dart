import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../ui-kit/widgets/forms/dropdown.dart';
import '../../../models/user.dart';
import '../../../repository/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
//import 'package:camera/camera.dart';


class DocumentationConfiguration extends StatefulWidget {
  const DocumentationConfiguration({super.key});

  @override
  createState() => _DocumentationConfiguration();
}

class _DocumentationConfiguration extends State<DocumentationConfiguration> {
  FormGroup buildForm() => fb.group(<String, Object>{
        'number': FormControl<String>(
          validators: [Validators.minLength(5)],
        ),
        'point': FormControl<String>(
          validators: [Validators.minLength(3)],
        ),
        'date': FormControl<DateTime>(value: null)
      });
  late FocusNode _focusNode;
  //late CameraDescription camera;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
    //camera = (await availableCameras()) as CameraDescription;
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
        builder: (context, form, child) {
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
                                      "Nazione",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    AppDropdownInput(
                                      hintText: "Nazione",
                                      options:
                                          countrieList.map((e) => e).toList(),
                                      value: countrieList[0],
                                      getLabel: (String value) => value,
                                      onChanged: (value) => {value},
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      "Tipo documento",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    AppDropdownInput(
                                      hintText: "Tipo documento",
                                      options: const [
                                        "Carta identita",
                                        "Codice fiscale",
                                        "Contratto",
                                        "Passaporto",
                                        "Patente",
                                        "Privacy",
                                        "Visura camerale"
                                      ],
                                      value: "Carta identita",
                                      getLabel: (String value) => value,
                                      onChanged: (value) => {value},
                                    ),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    Text(
                                      "Documento numero",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveTextField<String>(
                                        formControlName: 'number',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              'Email non deve essere vuota',
                                          ValidationMessage.email: (_) =>
                                              'Il valore dell e-mail deve essere un e-mail valida',
                                          'unique': (_) =>
                                              'Questa e-mail è già in uso',
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: '',
                                          helperText: '',
                                          counterText: currentUser.value.email,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      "Luogo di rilascio",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveTextField<String>(
                                        formControlName: 'point',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              'Email non deve essere vuota',
                                          ValidationMessage.email: (_) =>
                                              'Il valore dell e-mail deve essere un e-mail valida',
                                          'unique': (_) =>
                                              'Questa e-mail è già in uso',
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: '',
                                          helperText: '',
                                          counterText: currentUser.value.email,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    Text(
                                      "Data di emissione",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveDatePicker<DateTime>(
                                          formControlName: 'date',
                                          firstDate: DateTime(1985),
                                          lastDate: DateTime(2022),
                                          builder: (context, picker, child) {
                                            return Column(
                                              children: [
                                                ReactiveDatePicker<DateTime>(
                                                  formControlName: 'date',
                                                  firstDate: DateTime(1985),
                                                  lastDate: DateTime(2030),
                                                  builder:
                                                      (context, picker, child) {
                                                    Widget suffix = InkWell(
                                                      onTap: () {
                                                        _focusNode.unfocus();
                                                        _focusNode
                                                                .canRequestFocus =
                                                            false;
                                                        picker.control.value =
                                                            null;

                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    100), () {
                                                          _focusNode
                                                                  .canRequestFocus =
                                                              true;
                                                        });
                                                      },
                                                      child: Icon(Ionicons
                                                          .trash_outline),
                                                    );

                                                    if (picker.value == null) {
                                                      suffix = const Icon(
                                                          Icons.calendar_today);
                                                    }

                                                    return ReactiveTextField(
                                                      onTap: (_) {
                                                        if (_focusNode
                                                            .canRequestFocus) {
                                                          _focusNode.unfocus();
                                                          picker.showPicker();
                                                        }
                                                      },
                                                      valueAccessor:
                                                          DateTimeValueAccessor(
                                                        dateTimeFormat:
                                                            DateFormat(
                                                                'dd MMM yyyy'),
                                                      ),
                                                      focusNode: _focusNode,
                                                      formControlName: 'date',
                                                      readOnly: true,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: currentUser
                                                            .value.birth,
                                                        suffixIcon: suffix,
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            );
                                          }),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    TextButton(
                                        child: Text("Documento fronte"),
                                        onPressed: () => {}),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    TextButton(
                                        child: Text("Documento retro"),
                                        onPressed: () => {}),
                                    SizedBox(
                                      height: 25.0,
                                    ),
                                    PrimaryButton(
                                        onPressed: () async {
                                          if (form.valid) {
                                            // ignore: avoid_print
                                            print(form.value);
                                          } else {
                                            form.markAllAsTouched();
                                          }
                                        },
                                        text: "Aggiorna",
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
          ));
        });
  }
}
