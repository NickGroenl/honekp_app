// ignore_for_file: file_names

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:newhonekapp/app/models/bookings/members.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/bookings.dart';
import 'package:newhonekapp/app/repository/constants.dart';
import 'package:newhonekapp/app/routes/bookings/bookings_view.dart';
import 'package:newhonekapp/app/routes/user/user_configuration.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/forms/dropdown.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';

// CACHE DOCUMENTATION https://pub.dev/packages/cache_manager

class CheckinAll extends StatefulWidget {
  final int id;
  final List<MemberModell> members;
  final String status;
  final int index;
  const CheckinAll(
      {super.key,
      required this.id,
      required this.members,
      required this.status,
      required this.index});
  @override
  createState() => _CheckinAll();
}

class _CheckinAll extends State<CheckinAll> {
  String hours = '19:00';
  String errorMsg = '';
  bool isValid = true;
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
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.members.length; i++) {
      if (widget.members[i].image.length < 7) {
        setState(() {
          isValid = false;
        });
        break;
      }
    }
    if (isValid) {
      if (widget.status != 'booked') {
        Future.delayed(Duration.zero, () async {
          Helper.nextScreen(context, BookingView(bookingIndex: widget.index));
        });
      }
    }
    getTransalations(currentUser.value.default_language);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Scaffold(
            body: SingleChildScrollView(
                child: isValid
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SafeArea(child: SizedBox()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BackButton(),
                                Text(
                                  "Confermare il orario",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20.0,
                                    height: 1.5,
                                    color: Color.fromARGB(255, 71, 80, 106),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(''),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Orario di check-in",
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
                                  hintText: "Orario di check-in",
                                  options: const [
                                    "00:00",
                                    "01:00",
                                    "02:00",
                                    "03:00",
                                    "04:00",
                                    "05:00",
                                    "06:00",
                                    "07:00",
                                    "08:00",
                                    "09:00",
                                    "10:00",
                                    "11:00",
                                    "12:00",
                                    "13:00",
                                    "14:00",
                                    "15:00",
                                    "16:00",
                                    "17:00",
                                    "18:00",
                                    "19:00",
                                    "20:00",
                                    "21:00",
                                    "22:00",
                                    "23:00",
                                  ],
                                  value: hours,
                                  getLabel: (String value) => value,
                                  onChanged: (value) => hours = value!,
                                ),
                                SizedBox(
                                  height: 35.0,
                                ),
                                Text(
                                  errorMsg,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                PrimaryButton(
                                  onPressed: () async {
                                    var response = await checkinBooking({
                                      "id": widget.id,
                                      "checkin_hour": hours
                                    });
                                    if (response) {
                                      setState(() {
                                        errorMsg =
                                            'Hai aggiornato lorario di check-in';
                                      });
                                      Future.delayed(Duration.zero, () async {
                                        await getAllBookings();
                                        // ignore: use_build_context_synchronously
                                        Helper.nextScreen(
                                            context,
                                            BookingView(
                                              bookingIndex: widget.index,
                                            ));
                                      });
                                    } else {
                                      setState(() {
                                        errorMsg = 'Si è verificato un errore';
                                      });
                                    }
                                  },
                                  text: "Aggiungi",
                                ),
                                SizedBox(
                                  height: 45.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SafeArea(child: SizedBox()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BackButton(),
                                Text(
                                  "Checkin",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20.0,
                                    height: 1.5,
                                    color: Color.fromARGB(255, 71, 80, 106),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                InkWell(
                                    onTap: () => Helper.nextScreen(
                                        context, UserConfiguration()),
                                    child: Container(
                                      height: 40.0,
                                      width: 40.0,
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
                                                color: Colors.black12
                                                    .withOpacity(0.1),
                                                blurRadius: 10.0,
                                                spreadRadius: 2.0)
                                          ]),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 55.0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              "Check-in in sospeso \n",
                              style: GoogleFonts.roboto(
                                fontSize: 30.0,
                                height: 1.4,
                                color: Color.fromARGB(255, 71, 80, 106),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0),
                                child: Text(
                                  "Non potrai accedere alla tua prenotazione fino a quando tutti gli ospiti non avranno completato il check-in.",
                                  style: GoogleFonts.roboto(
                                    fontSize: 25.0,
                                    height: 1.4,
                                    color: Color.fromARGB(255, 71, 80, 106),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
          );
        });
  }
}
