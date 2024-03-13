import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/bookings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';

class AddMemberEmail extends StatefulWidget {
  final int bookingIndex;
  const AddMemberEmail({super.key, required this.bookingIndex});

  @override
  createState() => _AddMemberEmail();
}

class _AddMemberEmail extends State<AddMemberEmail> {
  late String errorMessage = '';

  final translator = GoogleTranslator();
  String addMember = 'Aggiungi Ospite';
  String email = 'Email';
  String emailInput = 'Il email ';
  String emailError = 'Il valore dell e-mail deve essere un e-mail valida';
  String successMessagge = 'Account aggiunto con successo';
  String errorMessaggee = 'Impossibile aggiungere laccount';
  String addMemberText = 'Invita per email';

  getTransalations(String lang) async {
    var addMemberCast =
        await translator.translate(addMember, from: 'it', to: lang);
    var emailCast = await translator.translate(email, from: 'it', to: lang);
    var emailInputCast =
        await translator.translate(emailInput, from: 'it', to: lang);
    var emailErrorCast =
        await translator.translate(emailError, from: 'it', to: lang);
    var successMessaggeCast =
        await translator.translate(successMessagge, from: 'it', to: lang);
    var errorMessaggeCast =
        await translator.translate(errorMessaggee, from: 'it', to: lang);
    var addMemberTextCast =
        await translator.translate(addMemberText, from: 'it', to: lang);
    setState(() {
      addMember = addMemberCast.text;
      email = emailCast.text;
      emailInput = emailInputCast.text;
      emailError = emailErrorCast.text;
      successMessagge = successMessaggeCast.text;
      errorMessaggee = errorMessaggeCast.text;
      addMemberText = addMemberTextCast.text;
    });

    return false;
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
      });
  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(Duration.zero);
      await getTransalations(currentUser.value.default_language);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Scaffold(
              body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SafeArea(child: SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButton(),
                          Spacer(),
                          Text(
                            addMember,
                            style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              height: 1.5,
                              color: Color.fromARGB(255, 71, 80, 106),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 15,
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
                          ValidationMessage.required: (_) => emailInput,
                          ValidationMessage.email: (_) => emailError
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
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
                        errorMessage,
                        style: GoogleFonts.roboto(
                          fontSize: 14.0,
                          color: Colors.grey,
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
                            var response = await addMemberBooking({
                              "bookingid": widget.bookingIndex,
                              "email": form.value["email"]
                            });
                            if (response) {
                              setState(() {
                                errorMessage = successMessagge;
                              });
                              getAllBookings();
                            } else {
                              setState(() {
                                errorMessage = errorMessaggee;
                              });
                            }
                          } else {
                            form.markAllAsTouched();
                          }
                        },
                        text: addMemberText,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                    ],
                  )));
        });
  }
}
