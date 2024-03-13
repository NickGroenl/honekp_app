import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/user/configuration/billing.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';
import '../../../../ui-kit/utils/constants.dart';
import '../../../models/user.dart';
import '../../../repository/user.dart';

class BillingPrivato extends StatefulWidget {
  final bool scanningManual;
  final bool steps;
  const BillingPrivato({super.key, required this.scanningManual, required this.steps});

  @override
  createState() => _BillingPrivato();
}

class _BillingPrivato extends State<BillingPrivato> {
  late var stateMessage = '';
  String insertDates = 'Inserisci tutti i dati di fatturazione';
  String region = "Region Sociale";
  String regionInput = 'Regione sociale non deve essere vuota';
  String name = "Nome";
  String lastname = 'Cognome';
  String fiscal = 'Codice Fiscale';
  String fiscalInput = 'Codice fiscale non deve essere vuota';
  String direction = "Indirizzo di fatturazione";
  String directionInput = 'Codice fiscale non deve essere vuota';
  String province = 'Provincia';
  String provinceInput = 'Codice fiscale non deve essere vuota';
  String capInput = 'Il CAP non deve essere vuota';
  String pecInput = 'Il PEC non deve essere vuota';
  String save = 'Salva';
  String saveDates = 'Hai modificato i tuoi dati';
  String private = 'Sei un cliente azienda?';
  String citta = 'Città';
  String nazione = 'Nazione';
  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var insertDatesCast =
        await translator.translate(insertDates, from: 'it', to: lang);
    var regionCast = await translator.translate(region, from: 'it', to: lang);
    var regionInputCast =
        await translator.translate(regionInput, from: 'it', to: lang);
    var nameCast = await translator.translate(name, from: 'it', to: lang);
    var fiscalCast = await translator.translate(fiscal, from: 'it', to: lang);
    var fiscalInputCast =
        await translator.translate(fiscalInput, from: 'it', to: lang);
    var directionCast =
        await translator.translate(direction, from: 'it', to: lang);
    var directionInputCast =
        await translator.translate(directionInput, from: 'it', to: lang);
    var provinceCast =
        await translator.translate(province, from: 'it', to: lang);
    var provinceInputCast =
        await translator.translate(provinceInput, from: 'it', to: lang);
    var privateCast = await translator.translate(private, from: 'it', to: lang);
    var capInputCast =
        await translator.translate(capInput, from: 'it', to: lang);
    var lastnameCast =
        await translator.translate(lastname, from: 'it', to: lang);
  
    var saveCast = await translator.translate(save, from: 'it', to: lang);
    var saveDatesCast =
        await translator.translate(saveDates, from: 'it', to: lang);
    var cittaCast =
        await translator.translate(citta, from: 'it', to: lang != '' ? lang : 'it');
    var nazioneCast =
        await translator.translate(nazione, from: 'it', to: lang != '' ? lang : 'it');
    setState(() {
      insertDates = insertDatesCast.text;
      region = regionCast.text;
      regionInput = regionInputCast.text;
      name = nameCast.text;
      fiscal = fiscalCast.text;
      fiscalInput = fiscalInputCast.text;
      direction = directionCast.text;
      directionInput = directionInputCast.text;
      province = provinceCast.text;
      provinceInput = provinceInputCast.text;
      private = privateCast.text;
      capInput = capInputCast.text;
      lastname = lastnameCast.text;
      save = saveCast.text;
      saveDates = saveDatesCast.text;
      nazione = nazioneCast.text;
      citta = cittaCast.text;
    });

    return false;
  }

  FormGroup Function() buildForm = () => fb.group(<String, Object>{
        'social': FormControl<String>(
          validators: [Validators.minLength(1)],
        ),
        'lastname': FormControl<String>(
          validators: [Validators.maxLength(11)],
        ),
        'codice': FormControl<String>(
          validators: [Validators.minLength(1)],
        ),
        'facturation': FormControl<String>(
          validators: [Validators.minLength(1)],
        ),
        'province': FormControl<String>(
          validators: [Validators.minLength(1), Validators.maxLength(2)],
        ),
        'capp': FormControl<String>(
          validators: [
            Validators.minLength(1),
            Validators.maxLength(5),
            Validators.number
          ],
        ),
        'name': FormControl<String>(
          validators: [Validators.minLength(1)],
        ),
        'citta': FormControl<String>(
              validators: [Validators.minLength(1)],
            ),
            'nazione': FormControl<String>(
              validators: [Validators.minLength(1)]
            ),
        
      });
  @override
  void initState() {
    super.initState();
    getUser(false);
    getTranslations(currentUser.value.default_language != ''
        ? currentUser.value.default_language
        : 'en');
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
                  widget.steps ? Image(
                            semanticLabel: "assets/images/logo.png",
                            image: AssetImage("assets/images/logo.png"),
                            width: 150,
                            height: 48,
                    ) : Text(''),
                  SizedBox(height: 25,),
                  widget.steps ? 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: <Widget>[
                        // ...

                        DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(9),
                              child: Text(
                                "1",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                        Expanded(child: Divider(color: Colors.black)),
                        DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(9),
                              child: Text(
                                "2",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),

                        Expanded(child: Divider(color: Colors.black)),
                        DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Constants.primaryColor,
                                  width: 2,
                                ),
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(9),
                              child: Text(
                                "3",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.0,
                                  height: 1.5,
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ) : Text(''),
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
                                      widget.steps ? 
                                      Text(
                                        insertDates,
                                        style: GoogleFonts.roboto(
                                          fontSize: 25.0,
                                          height: 1.5,
                                          color:
                                              Color.fromARGB(255, 45, 46, 50),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ) : Text(''),
                                      SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: widget.steps
                                          ? TextButton(
                                        onPressed: () => Helper.nextScreen(
                                            context,
                                            BillingConfiguration(
                                              back: false,
                                              scanningManual:
                                                  widget.scanningManual, steps: true,
                                            )),
                                        child: Text(private),
                                      ) : Text('')),
                                      SizedBox(height: 30,),
                                      
                                      Text(
                                                name,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14.0,
                                                  color:
                                                      Color.fromRGBO(138, 150, 191, 1),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                      ValueListenableBuilder(
                                        valueListenable: currentUser,
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return Column(
                                            children: [
                                              
                                              ReactiveTextField<String>(
                                                formControlName: 'name',
                                                readOnly: widget.scanningManual,
                                                validationMessages: {
                                                  ValidationMessage.required: (_) =>
                                                      'Regione sociale non deve essere vuota',
                                                  
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  labelText: (currentUser
                                                                  .value.name !=
                                                              '' &&
                                                          currentUser
                                                                  .value.name !=
                                                              'nulling')
                                                      ? currentUser.value.name
                                                      : '',
                                                  helperText: '',
                                                  counterText:
                                                      currentUser.value.name,
                                                  helperStyle:
                                                      TextStyle(height: 0.7),
                                                  errorStyle:
                                                      TextStyle(height: 0.7),
                                                ),
                                              ),

                                            ],
                                          );
                                        },
                                      ),
                                      Text(
                                                lastname.replaceAll(' ', ''),
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14.0,
                                                  color: Color.fromRGBO(
                                                      138, 150, 191, 1),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),

                                      ValueListenableBuilder(
                                        valueListenable: currentUser,
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return Column(
                                            children: [
                                              
                                              
                                              ReactiveTextField<String>(
                                                formControlName: 'lastname',
                                                readOnly: widget.scanningManual,
                                                validationMessages: {
                                                  ValidationMessage.required: (_) =>
                                                      'Regione sociale non deve essere vuota',
                                                  'unique': (_) =>
                                                      'Questa e-mail è già in uso',
                                                },
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                  labelText: (currentUser.value
                                                                  .lastname !=
                                                              '' &&
                                                          currentUser.value
                                                                  .lastname !=
                                                              'nulling')
                                                      ? currentUser
                                                          .value.lastname
                                                      : '',
                                                  helperText: '',
                                                  counterText:
                                                      currentUser.value.lastname,
                                                  helperStyle:
                                                      TextStyle(height: 0.7),
                                                  errorStyle:
                                                      TextStyle(height: 0.7),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      Text(
                                        nazione,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'nazione',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              regionInput,
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText:
                                              currentUser.value.nazione != ''
                                                  ? currentUser.value.nazione
                                                  : '',
                                          helperText: '',
                                          counterText: currentUser.value.nazione,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        citta,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'citta',
                                        
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText:
                                              currentUser.value.citta != ''
                                                  ? currentUser.value.citta
                                                  : '',
                                          helperText: '',
                                          counterText: currentUser.value.citta,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        fiscal,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'codice',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              fiscalInput
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: currentUser
                                                      .value.fiscal_code !=
                                                  ''
                                              ? currentUser.value.fiscal_code
                                              : '',
                                          helperText: '',
                                          counterText: currentUser.value.fiscal_code,
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
                                        formControlName: 'facturation',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              directionInput
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: currentUser
                                                      .value.address_bill !=
                                                  ''
                                              ? currentUser.value.address_bill
                                              : '',
                                          helperText: '',
                                          counterText: currentUser.value.address_bill,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        province,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'province',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              provinceInput
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: currentUser
                                                      .value.province_bill !=
                                                  ''
                                              ? currentUser.value.province_bill
                                              : '',
                                          helperText: '',
                                          counterText: currentUser.value.province_bill,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        "CAP",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'capp',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              capInput
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText:
                                              currentUser.value.zip_bill != ''
                                                  ? currentUser.value.zip_bill
                                                  : '',
                                          helperText: '',
                                          counterText: currentUser.value.zip_bill,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                      
                                     
                                      SizedBox(
                                        height: 65.0,
                                      ),
                                      PrimaryButton(
                                          text: save,
                                          onPressed: () async => {
                                                if (form.valid)
                                                  {
                                                    await updateBilling(
                                                        context, {
                                                      'city_bill': form.value[
                                                              'social'] ??
                                                          currentUser
                                                              .value.city_bill,
                                                      'vat': form
                                                              .value['iva'] ??
                                                          currentUser.value.vat,
                                                      'fiscal_code': form.value[
                                                              'codice'] ??
                                                          currentUser.value
                                                              .fiscal_code,
                                                      'address_bill': form
                                                                  .value[
                                                              'facturation'] ??
                                                          currentUser.value
                                                              .address_bill,
                                                      'province_bill': form
                                                                  .value[
                                                              'province'] ??
                                                          currentUser.value
                                                              .province_bill,
                                                      'zip_code':
                                                          form.value['capp'] ??
                                                              currentUser.value
                                                                  .zip_code,
                                                      'pec': form
                                                              .value['pec'] ??
                                                          currentUser.value.pec,
                                                      'sdi_code' : '00',
                                                      'citta':
                                                          form.value['citta'] ??
                                                              currentUser.value.citta,
                                                      'nazione':
                                                          form.value['nazione'] ??
                                                              currentUser.value
                                                                  .nazione
                                                      
                                                    }),
                                                    await getUser(false),
                                                  }
                                                else
                                                  {form.markAllAsTouched()}
                                              }),
                                              SizedBox(
                                        height: 15.0,
                                      ),
                                      
                                      
                                      SizedBox(
                                        height: 95.0,
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
