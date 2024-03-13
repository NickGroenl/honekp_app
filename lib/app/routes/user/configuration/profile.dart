import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/repository/user.dart';
import 'package:newhonekapp/app/routes/user/%20blinkid/scan_blink.dart';
import 'package:newhonekapp/app/routes/user/user_configuration.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';
import '../../../../ui-kit/utils/helper.dart';
import '../../../../ui-kit/widgets/forms/dropdown.dart';

class ProfileConfiguration extends StatefulWidget {
  const ProfileConfiguration({super.key});

  @override
  createState() => _ProfileConfiguration();
}

class _ProfileConfiguration extends State<ProfileConfiguration> {
  String name = 'Nome';
  String nameInput = 'Il nome non deve essere vuota';
  String lastname = "Cognome";
  String lastnameInput = 'Il cognome non deve essere vuota';
  String emailInput = 'Il email non deve essere vuota';
  String phone = 'Cellulare';
  String phoneInput = 'Il email non deve essere vuota';
  String currency = 'Valuta';
  String langg = 'Lingua';
  String birth = 'Data di nascita';
  String saveDates = 'Hai modificato i tuoi dati';

  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var nameCast = await translator.translate(name, from: 'it', to: lang);
    var lastnameCast =
        await translator.translate(lastname, from: 'it', to: lang);
    var phoneCast = await translator.translate(phone, from: 'it', to: lang);
    var phoneInputCast =
        await translator.translate(phoneInput, from: 'it', to: lang);
    var currencyCast =
        await translator.translate(currency, from: 'it', to: lang);
    var langgCast = await translator.translate(langg, from: 'it', to: lang);
    var birthCast = await translator.translate(birth, from: 'it', to: lang);
    var savedDatesCast =
        await translator.translate(saveDates, from: 'it', to: lang);
    setState(() {
      name = nameCast.text;
      lastname = lastnameCast.text;
      phone = phoneCast.text;
      phoneInput = phoneInputCast.text;
      currency = currencyCast.text;
      langg = langgCast.text;
      birth = birthCast.text;
      saveDates = savedDatesCast.text;
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
        'email': FormControl<String>(
          validators: [Validators.email],
        ),
        'phone': FormControl<String>(
          validators: [Validators.minLength(5)],
        ),
        'date': FormControl<String>()
      });

  late FocusNode _focusNode;

  late String lang = '';
  late String coin = '';
  String stateMessage = '';
  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
    getTranslations(currentUser.value.default_language);
    if (currentUser.value.default_language != 'it' ||
        currentUser.value.default_language != 'en') {
      currentUser.value.default_language = 'it';
    }
    if (currentUser.value.currency != 'eur' ||
        currentUser.value.currency != 'usd') {
      currentUser.value.currency = 'eur';
    }
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
          return ValueListenableBuilder(
            valueListenable: currentUser,
            builder: (BuildContext context, value, Widget? child) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SafeArea(bottom: false, child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [BackButton()],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(14.0),
                        child: InkWell(
                            onTap: () =>
                                Helper.nextScreen(context, UserConfiguration()),
                            child: Container(
                              height: 70.0,
                              width: 70.0,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            name,
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(
                                                  138, 150, 191, 1),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          ReactiveTextField<String>(
                                            formControlName: 'name',
                                            readOnly: true,
                                            validationMessages: {
                                              ValidationMessage.required: (_) =>
                                                  nameInput
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              labelText: currentUser.value.name,
                                              helperText: '',
                                              helperStyle:
                                                  TextStyle(height: 0.7),
                                              errorStyle:
                                                  TextStyle(height: 0.7),
                                            ),
                                          ),
                                          SizedBox(height: 15.0),
                                          Text(
                                            lastname,
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(
                                                  138, 150, 191, 1),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          ReactiveTextField<String>(
                                            formControlName: 'lastname',
                                            readOnly: true,
                                            validationMessages: {
                                              ValidationMessage.required: (_) =>
                                                  lastnameInput
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              labelText:
                                                  currentUser.value.lastname,
                                              helperText: '',
                                              helperStyle:
                                                  TextStyle(height: 0.7),
                                              errorStyle:
                                                  TextStyle(height: 0.7),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Text(
                                            "Email",
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(
                                                  138, 150, 191, 1),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          ReactiveTextField<String>(
                                            formControlName: 'email',
                                            readOnly: true,
                                            validationMessages: {
                                              ValidationMessage.required: (_) =>
                                                  emailInput
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              labelText:
                                                  currentUser.value.email,
                                              helperText: '',
                                              helperStyle:
                                                  TextStyle(height: 0.7),
                                              errorStyle:
                                                  TextStyle(height: 0.7),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Text(
                                            phone,
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(
                                                  138, 150, 191, 1),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          ReactiveTextField<String>(
                                            formControlName: 'phone',
                                            validationMessages: {
                                              ValidationMessage.required: (_) =>
                                                  phoneInput
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              helperText: '',
                                              labelText:
                                                  currentUser.value.mobile,
                                              helperStyle:
                                                  TextStyle(height: 0.7),
                                              errorStyle:
                                                  TextStyle(height: 0.7),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Text(
                                            birth,
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(
                                                  138, 150, 191, 1),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          ReactiveTextField<String>(
                                            formControlName: 'date',
                                            readOnly: true,
                                            validationMessages: {
                                              ValidationMessage.required: (_) =>
                                                  'Email non deve essere vuota',
                                              ValidationMessage.email: (_) =>
                                                  'Il valore dell e-mail deve essere un e-mail valida',
                                              'unique': (_) =>
                                                  'Questa e-mail è già in uso',
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            decoration: InputDecoration(
                                              helperText: '',
                                              labelText:
                                                  currentUser.value.birth,
                                              helperStyle:
                                                  TextStyle(height: 0.7),
                                              errorStyle:
                                                  TextStyle(height: 0.7),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25.0,
                                          ),
                                          Text(
                                            langg,
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(
                                                  138, 150, 191, 1),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          AppDropdownInput(
                                            hintText: lang,
                                            options: getLangNames()
                                                .map((e) => e)
                                                .toList(),
                                            value: "Italian",
                                            getLabel: (String? value) => value!,
                                            onChanged: (value) => {
                                              setState(() {
                                                lang = getLangCodes()[
                                                    getLangNames()
                                                        .indexOf(value)]!;
                                              }),
                                            },
                                          ),
                                          SizedBox(
                                            height: 25.0,
                                          ),
                                          Text(
                                            currency,
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.0,
                                              color: Color.fromRGBO(
                                                  138, 150, 191, 1),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          AppDropdownInput(
                                            hintText: currency,
                                            options: const ["eur", "usd"],
                                            value: currentUser.value.currency,
                                            getLabel: (String value) => value,
                                            onChanged: (value) =>
                                                {coin = value ?? ''},
                                          ),
                                          SizedBox(
                                            height: 35.0,
                                          ),
                                          Text(
                                            stateMessage,
                                            style: GoogleFonts.roboto(
                                              fontSize: 18.0,
                                              color: Color.fromARGB(
                                                  255, 77, 131, 72),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25.0,
                                          ),
                                          PrimaryButton(
                                            onPressed: () async {
                                              if (form.valid) {
                                                if (await updateProfile({
                                                  "language": lang,
                                                  "currency": coin,
                                                  "phone": form
                                                          .value['phone'] ??
                                                      currentUser.value.mobile
                                                })) {
                                                  setState(() {
                                                    stateMessage = saveDates;
                                                  });
                                                } else {
                                                  setState(() {
                                                    stateMessage =
                                                        'Cè stato un problema';
                                                  });
                                                }
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
                ),
              );
            },
          );
        });
  }
}
