import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/app/repository/user.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';

class PasswordConfiguration extends StatefulWidget {
  const PasswordConfiguration({super.key});

  @override
  createState() => _PasswordConfiguration();
}

class _PasswordConfiguration extends State<PasswordConfiguration> {
  late var stateMessage = '';
  String saveDates = 'Hai modificato i tuoi dati';
  String confirma = "Conferma password";
  String passwordInput = 'Password non deve essere vuota';

  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var confirmaCast =
        await translator.translate(confirma, from: 'it', to: lang);
    var passwordInputCast =
        await translator.translate(passwordInput, from: 'it', to: lang);
    var saveDatesCast =
        await translator.translate(saveDates, from: 'it', to: lang);
    setState(() {
      confirma = confirmaCast.text;
      saveDates = saveDatesCast.text;
      passwordInput = passwordInputCast.text;
    });

    return false;
  }

  final buildForm = FormGroup({
    'password': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(6),
    ]),
    'newpassword': FormControl<String>(),
  }, validators: [
    Validators.mustMatch('password', 'newpassword')
  ]);

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
        form: () => buildForm,
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
                                        "Password",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'password',
                                        obscureText: true,
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              passwordInput
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
                                      Text(
                                        confirma,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'newpassword',
                                        obscureText: true,
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              passwordInput,
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
                                        height: 35.0,
                                      ),
                                      Text(
                                        stateMessage,
                                        style: GoogleFonts.roboto(
                                          fontSize: 18.0,
                                          color:
                                              Color.fromARGB(255, 77, 131, 72),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      PrimaryButton(
                                        onPressed: () async {
                                          if (form.valid) {
                                            await updatePassword({
                                              'password':
                                                  form.value['password'],
                                            }, context);
                                            setState(() {
                                              stateMessage = saveDates;
                                            });
                                          } else {
                                            form.markAllAsTouched();
                                          }
                                        },
                                        text: "Salva",
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
        });
  }
}
