import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';

class CheckinForm extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final finishForm;
  const CheckinForm({super.key, required this.finishForm});

  @override
  createState() => _CheckinForm();
}

class _CheckinForm extends State<CheckinForm> {
  final translator = GoogleTranslator();
  String name = 'Nome';
  String nameInput = 'Il nome non deve essere vuota';
  String lastname = 'Arriva del';
  String lastnameInput = 'Il cognome non deve essere vuota';
  String phone = 'Telefono';
  String phoneInput = "Il telefono non deve essere vuota";
  String aggiungi = 'Aggiungi';
  getTransalations(String lang) async {
    var nameCast = await translator.translate(name, from: 'it', to: lang);
    var nameInputCast =
        await translator.translate(nameInput, from: 'it', to: lang);
    var lastnameCast =
        await translator.translate(lastname, from: 'it', to: lang);
    var lastnameInputCast =
        await translator.translate(lastnameInput, from: 'it', to: lang);
    var phoneCast = await translator.translate(phone, from: 'it', to: lang);
    var phoneInputCast =
        await translator.translate(phoneInput, from: 'it', to: lang);
    var aggiungiCast =
        await translator.translate(aggiungi, from: 'it', to: lang);
    setState(() {
      name = nameCast.text;
      lastname = lastnameCast.text;
      nameInput = nameInputCast.text;
      lastnameInput = lastnameInputCast.text;
      phone = phoneCast.text;
      phoneInput = phoneInputCast.text;
      aggiungi = aggiungiCast.text;
    });

    return false;
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(
          validators: [Validators.minLength(3)],
        ),
        'lastname': FormControl<String>(
          validators: [Validators.minLength(3)],
        ),
        'phone': FormControl<String>(
          validators: [Validators.required, Validators.minLength(3)],
        ),
      });
  late FocusNode _focusNode;
  //late CameraDescription camera;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
    getTransalations(currentUser.value.default_language);
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
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color.fromARGB(255, 244, 245, 246),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            ValidationMessage.required: (_) => nameInput,
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: '',
                            helperText: '',
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
                            ValidationMessage.required: (_) => lastnameInput,
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: '',
                            helperText: '',
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
                            ValidationMessage.required: (_) => phoneInput,
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: '',
                            helperText: '',
                            helperStyle: TextStyle(height: 0.7),
                            errorStyle: TextStyle(height: 0.7),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        PrimaryButton(
                          onPressed: () async {
                            if (form.valid) {
                              // ignore: avoid_print
                              widget.finishForm({...form.value});
                            } else {
                              form.markAllAsTouched();
                            }
                          },
                          text: aggiungi,
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                      ],
                    ),
                  )));
        });
  }
}
