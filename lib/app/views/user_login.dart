import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/user.dart';
import 'package:newhonekapp/app/routes/%20loading.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';

import '../routes/user/forgot_password.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  late String errorMessage = '';
  String passwordInput = 'Password non deve essere vuota.';
  String passwordInput2 = 'La password deve essere di almeno 8 caratteri.';
  String emailInput = 'Il email non deve essere vuota.';
  String passwordDimenticata = "Password dimenticata?";
  String access = 'Login';
  String saveDate = 'Email o password errate';

  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var passwordInputCast =
        await translator.translate(passwordInput, from: 'it', to: lang);
    var passwordInputCast2 =
        await translator.translate(passwordInput2, from: 'it', to: lang);
    var emailInputCast =
        await translator.translate(emailInput, from: 'it', to: lang);
    var saveDateCast =
        await translator.translate(saveDate, from: 'it', to: lang);
    var passwordDimenticataCast =
        await translator.translate(passwordDimenticata, from: 'it', to: lang);
    var accessCast = await translator.translate(access, from: 'it', to: lang);

    setState(() {
      passwordInput = passwordInputCast.text;
      passwordInput2 = passwordInputCast2.text;
      emailInput = emailInputCast.text;
      saveDate = saveDateCast.text;
      access = accessCast.text;
      passwordDimenticata = passwordDimenticataCast.text;
    });

    return false;
  }
  @override
  void initState() {
    super.initState();
    getTranslations(currentUser.value.default_language != '' ? currentUser.value.default_language : 'en');
    
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'password': ['', Validators.required, Validators.minLength(6)],
      });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Email",
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  color: Color.fromRGBO(138, 150, 191, 1),
                  fontWeight: FontWeight.w400,
                ),
              ),
              ReactiveTextField<String>(
                formControlName: 'email',
                validationMessages: {
                  ValidationMessage.required: (_) => emailInput
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: '',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                "Password",
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  color: Color.fromRGBO(138, 150, 191, 1),
                  fontWeight: FontWeight.w400,
                ),
              ),
              ReactiveTextField<String>(
                formControlName: 'password',
                obscureText: true,
                validationMessages: {
                  ValidationMessage.required: (_) => passwordInput,
                  ValidationMessage.minLength: (_) => passwordInput2,
                },
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: '',
                  helperText: '',
                  helperStyle: TextStyle(height: 0.7),
                  errorStyle: TextStyle(height: 0.7),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                errorMessage,
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  color: Constants.errorColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              PrimaryButton(
                onPressed: () async {
                  if (form.valid) {
                    // ignore: avoid_print
                    Future<bool> response = sendLogin({
                      'email': form.value["email"],
                      'password': form.value["password"]
                    });
                    if (await response) {
                      // ignore: use_build_context_synchronously
                      Helper.nextScreen(context, LoadingPage());
                    } else {
                      setState(() {
                        errorMessage = saveDate;
                      });
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
                text: access,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 107, 111, 114),
                  disabledBackgroundColor: Color.fromARGB(255, 149, 149, 149),
                ),
                onPressed: () => Helper.nextScreen(context, ForgotPassword()),
                child: Text(
                  passwordDimenticata,
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 154, 157, 166),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            ],
          );
        });
  }
}
