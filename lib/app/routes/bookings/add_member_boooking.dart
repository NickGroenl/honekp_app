/*import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';
import '../../../ui-kit/widgets/forms/dropdown.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AddMemberBooking extends StatefulWidget {
  const AddMemberBooking({super.key});

  @override
  createState() => _AddMemberBooking();
}

class _AddMemberBooking extends State<AddMemberBooking> {
  final translator = GoogleTranslator();
  String name = 'Nome';
  String nameInput = 'Cognome';
  String nameError = "Destinazioni popolari";




  getTransalations(String lang) async {
    var prenotazioniCast =
        await translator.translate(name, from: 'it', to: lang);
    
    setState(() {
      name = prenotazioniCast.text;
    });

    return false;
  }
  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(
          validators: [Validators.required, Validators.minLength(3)],
        ),
        'lastname': FormControl<String>(
          validators: [Validators.required, Validators.minLength(3)],
        ),
        'direction': FormControl<String>(
          validators: [Validators.required, Validators.minLength(3)],
        ),
        'phone': FormControl<String>(
            validators: [Validators.required, Validators.minLength(5)]),
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'startdate': FormControl<DateTime>(value: null),
        'enddate': FormControl<DateTime>(value: null)
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
                                      name,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveTextField<String>(
                                      formControlName: 'name',
                                      validationMessages: {
                                        ValidationMessage.required: (_) =>
                                            nameInput,
                                        ValidationMessage.email: (_) =>
                                            nameError,
                                        
                                      },
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
                                      lastname,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveTextField<String>(
                                      formControlName: 'lastname',
                                      validationMessages: {
                                        ValidationMessage.required: (_) =>
                                            lastnameInput,
                                        ValidationMessage.email: (_) =>
                                            lastnameError,
                                        'unique': (_) =>
                                            'Questa e-mail è già in uso',
                                      },
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
                                      indirizzo,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveTextField<String>(
                                      formControlName: 'direction',
                                      validationMessages: {
                                        ValidationMessage.required: (_) =>
                                            indirizzoInput,
                                        ValidationMessage.email: (_) =>
                                            indirizzoEmail,
                                        
                                      },
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
                                      phone,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveTextField<String>(
                                      formControlName: 'phone',
                                      validationMessages: {
                                        ValidationMessage.required: (_) =>
                                            phoneInput,
                                        ValidationMessage.email: (_) =>
                                            phoneError,
                                        
                                      },
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
                                      height: 15.0,
                                    ),
                                    Text(
                                      email,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveTextField<String>(
                                      formControlName: 'email',
                                      validationMessages: {
                                        ValidationMessage.required: (_) =>
                                            emailInput,
                                        ValidationMessage.email: (_) =>
                                            emailError,
                                      },
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
                                      height: 15.0,
                                    ),
                                    Text(
                                      type,
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
                                      hintText: type,
                                      options: const [ospiti, bambini],
                                      value: type,
                                      getLabel: (String value) => value,
                                      onChanged: (value) => {value},
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      from,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ReactiveDatePicker<DateTime>(
                                        formControlName: 'startdate',
                                        firstDate: DateTime(1985),
                                        lastDate: DateTime(2022),
                                        builder: (context, picker, child) {
                                          return Column(
                                            children: [
                                              ReactiveDatePicker<DateTime>(
                                                formControlName: 'startdate',
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
                                                    child: Icon(
                                                        Ionicons.trash_outline),
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
                                                    formControlName:
                                                        'startdate',
                                                    readOnly: true,
                                                    decoration: InputDecoration(
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
                                      height: 20.0,
                                    ),
                                    Text(
                                      to,
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    ReactiveDatePicker<DateTime>(
                                        formControlName: 'enddate',
                                        firstDate: DateTime(1985),
                                        lastDate: DateTime(2022),
                                        builder: (context, picker, child) {
                                          return Column(
                                            children: [
                                              ReactiveDatePicker<DateTime>(
                                                formControlName: 'enddate',
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
                                                    child: Icon(
                                                        Ionicons.trash_outline),
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
                                                    formControlName: 'enddate',
                                                    readOnly: true,
                                                    decoration: InputDecoration(
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
                                      height: 25.0,
                                    ),
                                    PrimaryButton(
                                        text: save, onPressed: () => {}),
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
*/