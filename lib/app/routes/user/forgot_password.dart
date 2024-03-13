import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';
import '../../../ui-kit/utils/constants.dart';
import '../../repository/user.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Wrap(
                  runAlignment: WrapAlignment.center,
                  children: [
                    SafeArea(child: SizedBox()),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 30.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: double.infinity,
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 35.0,
                          ),
                          Image(
                            semanticLabel: "assets/images/logo.png",
                            image: AssetImage("assets/images/logo.png"),
                            width: 150,
                            height: 48,
                          ),
                          SizedBox(
                            height: 90.0,
                          ),

                          SizedBox(
                            height: 15.0,
                          ),
                          //Leta take the form to a new page
                          ForgotPasswordForm(),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  createState() => _ForgotPasswordForm();
}

class _ForgotPasswordForm extends State<ForgotPasswordForm> {
  late String errorMessage = '';
  String problem = "Problemi di accesso?";
  String insert =
      "Inserisci il tuo indirizzo e-mail e ti invieremo il reset della password per accedere di nuovo al tuo account.";

  String emailInput = 'Il email non deve essere vuota';
  String saveDate = 'Se le-mail è corretta, riceverai la nuova password';
  String ripristina = 'Ripristina';

  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    print(lang);
    var problemCast = await translator.translate(problem, from: 'it', to: lang);
    var insertCast = await translator.translate(insert, from: 'it', to: lang);
    var emailInputCast =
        await translator.translate(emailInput, from: 'it', to: lang);
    var saveDateCast =
        await translator.translate(saveDate, from: 'it', to: lang);
    var ripristinaCast =
        await translator.translate(ripristina, from: 'it', to: lang);

    setState(() {
      problem = problemCast.text;
      insert = insertCast.text;
      emailInput = emailInputCast.text;
      saveDate = saveDateCast.text;
      ripristina = ripristinaCast.text;
    });

    return false;
  }

  void initState() {
    super.initState();
    getTranslations(currentUser.value.default_language != '' ? currentUser.value.default_language : 'en');
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
      });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Icon(
                Ionicons.lock_closed_outline,
                size: 40,
              )),
              SizedBox(
                height: 15.0,
              ),
              Center(
                  child: Text(
                problem,
                style: GoogleFonts.roboto(
                  fontSize: 22.0,
                  color: Color.fromARGB(255, 67, 71, 85),
                  fontWeight: FontWeight.w600,
                ),
              )),
              SizedBox(
                height: 15.0,
              ),
              Center(
                  child: Text(
                insert,
                style: GoogleFonts.roboto(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 102, 110, 140),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 15.0,
              ),
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
                  ValidationMessage.required: (_) => emailInput,
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
              SizedBox(
                height: 35.0,
              ),
              Text(
                errorMessage,
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              PrimaryButton(
                onPressed: () async {
                  if (form.valid) {
                    // ignore: avoid_print
                    if (await resetPassword({
                      'email': form.value["email"],
                    })) {
                      setState(() {
                        errorMessage = saveDate;
                      });
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
                text: ripristina,
              ),
            ],
          );
        });
  }
}
