import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/user/configuration/billing.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/forms/dropdown.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';
import '../../../models/user.dart';
import '../../../repository/user.dart';

class BlinkDatesConfiguration extends StatefulWidget {
  const BlinkDatesConfiguration({super.key});

  @override
  createState() => _BlinkDatesConfiguration();
}

class _BlinkDatesConfiguration extends State<BlinkDatesConfiguration> {
  late var stateMessage = '';
  late String gender = '';

  final translator = GoogleTranslator();
  String name = 'Nome';
  String nameInput = 'Il nome non deve essere vuota';
  String lastname = "Cognome";
  String lastnameInput = 'Il cognome non deve essere vuota';
  String birth = 'Data di nascita';
  String numberDocument = 'Numero del documento';
  String numberDocumentInput = 'Il numero del documento non deve essere vuota';
  String expiredDocument = "Scadenza del documento";
  String direction = 'Indirizzo';
  String directionInput = 'Il indirizzo di nascita non deve essere vuota';
  String placebirth = "Luogo di nascita";
  String placebirthInput = 'Il luogo di nascita non deve essere vuota';
  String save = 'Salva';

  getTranslations(String lang) async {
    var nameCast = await translator.translate(name, from: 'it', to: lang);
    var nameInputCast =
        await translator.translate(nameInput, from: 'it', to: lang);
    var lastnameCast =
        await translator.translate(lastname, from: 'it', to: lang);
    var lastnameInputCast =
        await translator.translate(lastnameInput, from: 'it', to: lang);
    var birthCast = await translator.translate(birth, from: 'it', to: lang);
    var numberDocumentCast =
        await translator.translate(numberDocument, from: 'it', to: lang);
    var expiredDocumentCast =
        await translator.translate(expiredDocument, from: 'it', to: lang);
    var directionCast =
        await translator.translate(direction, from: 'it', to: lang);
    var directionInputCast =
        await translator.translate(directionInput, from: 'it', to: lang);
    var placebirthCast =
        await translator.translate(placebirth, from: 'it', to: lang);
    var placebirthInputCast =
        await translator.translate(placebirthInput, from: 'it', to: lang);
    var saveCast = await translator.translate(save, from: 'it', to: lang);

    setState(() {
      name = nameCast.text;
      nameInput = nameInputCast.text;
      lastname = lastnameCast.text;
      lastnameInput = lastnameInputCast.text;
      birth = birthCast.text;
      numberDocument = numberDocumentCast.text;
      expiredDocument = expiredDocumentCast.text;
      direction = directionCast.text;
      directionInput = directionInputCast.text;
      placebirth = placebirthCast.text;
      placebirthInput = placebirthInputCast.text;
      save = saveCast.text;
    });

    return false;
  }

  FormGroup Function() buildForm = () => fb.group(<String, Object>{
        'name': FormControl<String>(
          validators: [Validators.minLength(1), Validators.required],
        ),
        'lastname': FormControl<String>(
          validators: [Validators.minLength(1), Validators.required],
        ),
        'address': FormControl<String>(
          validators: [Validators.minLength(1), Validators.required],
        ),
        'birth': FormControl<DateTime>(
          validators: [Validators.required],
        ),
        'numberdocument': FormControl<String>(
          validators: [Validators.required],
        ),
        'expireddocument': FormControl<DateTime>(
          validators: [Validators.required],
        ),
        'placebirth': FormControl<String>(
          validators: [Validators.minLength(1), Validators.required],
        ),
      });
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
    getTranslations(currentUser.value.default_language);
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
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'name',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              nameInput,
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
                                        lastname,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'lastname',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              lastnameInput
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
                                        birth,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveDatePicker<DateTime>(
                                        formControlName: 'birth',
                                        firstDate: DateTime(1965),
                                        lastDate: DateTime(2020),
                                        builder: (context, picker, child) {
                                          Widget suffix = InkWell(
                                            onTap: () {
                                              // workaround until https://github.com/flutter/flutter/issues/39376
                                              // will be fixed

                                              // Unfocus all focus nodes
                                              _focusNode.unfocus();

                                              // Disable text field's focus node request
                                              _focusNode.canRequestFocus =
                                                  false;

                                              // clear field value
                                              picker.control.value = null;

                                              //Enable the text field's focus node request after some delay
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 100), () {
                                                _focusNode.canRequestFocus =
                                                    true;
                                              });
                                            },
                                            child: const Icon(Icons.clear),
                                          );

                                          if (picker.value == null) {
                                            suffix = const Icon(
                                                Icons.calendar_today);
                                          }

                                          return ReactiveTextField(
                                            onTap: (_) {
                                              if (_focusNode.canRequestFocus) {
                                                _focusNode.unfocus();
                                                picker.showPicker();
                                              }
                                            },
                                            valueAccessor:
                                                DateTimeValueAccessor(
                                              dateTimeFormat:
                                                  DateFormat('dd MMM yyyy'),
                                            ),
                                            focusNode: _focusNode,
                                            formControlName: 'birth',
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: birth,
                                              suffixIcon: suffix,
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        numberDocument,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'numberdocument',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              numberDocumentInput
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
                                        expiredDocument,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveDatePicker<DateTime>(
                                        formControlName: 'expireddocument',
                                        firstDate: DateTime(1985),
                                        lastDate: DateTime(2030),
                                        builder: (context, picker, child) {
                                          Widget suffix = InkWell(
                                            onTap: () {
                                              // workaround until https://github.com/flutter/flutter/issues/39376
                                              // will be fixed

                                              // Unfocus all focus nodes
                                              _focusNode.unfocus();

                                              // Disable text field's focus node request
                                              _focusNode.canRequestFocus =
                                                  false;

                                              // clear field value
                                              picker.control.value = null;

                                              //Enable the text field's focus node request after some delay
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 100), () {
                                                _focusNode.canRequestFocus =
                                                    true;
                                              });
                                            },
                                            child: const Icon(Icons.clear),
                                          );

                                          if (picker.value == null) {
                                            suffix = const Icon(
                                                Icons.calendar_today);
                                          }

                                          return ReactiveTextField(
                                            onTap: (_) {
                                              if (_focusNode.canRequestFocus) {
                                                _focusNode.unfocus();
                                                picker.showPicker();
                                              }
                                            },
                                            valueAccessor:
                                                DateTimeValueAccessor(
                                              dateTimeFormat:
                                                  DateFormat('dd MMM yyyy'),
                                            ),
                                            focusNode: _focusNode,
                                            formControlName: 'expireddocument',
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: expiredDocument,
                                              suffixIcon: suffix,
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        placebirth,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'placebirth',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              placebirthInput
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
                                        direction,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'address',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              directionInput
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
                                        height: 25.0,
                                      ),
                                      PrimaryButton(
                                          text: save,
                                          onPressed: () async => {
                                                print(form.value),
                                                if (form.valid)
                                                  {
                                                    if (await scanReadyDates({
                                                      "name":
                                                          form.value['name'],
                                                      "lastname": form
                                                          .value['lastname'],
                                                      "address":
                                                          form.value['address'],
                                                      "birth": form
                                                          .value['birth']
                                                          .toString(),
                                                      "gender": 'Non definito',
                                                      "number_document":
                                                          form.value[
                                                              'numberdocument'],
                                                      "expired_document": form
                                                          .value[
                                                              'expireddocument']
                                                          .toString(),
                                                      "placebirth": form
                                                          .value['placebirth']
                                                    }))
                                                      {
                                                        Helper.nextScreen(
                                                            context,
                                                            BillingConfiguration(
                                                                back: false, scanningManual: true, steps: true,))
                                                      }
                                                  }
                                                else
                                                  {form.markAllAsTouched()}
                                              }),
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
