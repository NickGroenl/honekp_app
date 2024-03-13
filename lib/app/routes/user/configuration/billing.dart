import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/user/configuration/billing.privato.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';
import '../../../models/user.dart';
import '../../../repository/user.dart';

class BillingConfiguration extends StatefulWidget {
  final bool back;
  final bool scanningManual;
  final bool steps;
  const BillingConfiguration(
      {super.key, required this.back, required this.scanningManual, required this.steps});

  @override
  createState() => _BillingConfiguration();
}

class _BillingConfiguration extends State<BillingConfiguration> {
  late var stateMessage = '';
  String insertDates = 'Inserisci i dati di fatturazione';
  String region = "Region Sociale";
  String regionInput = 'Regione sociale non deve essere vuota';
  String iva = "Partita IVA";
  String ivaInput = 'Il iva non deve essere vuota';
  String fiscal = 'Codice Fiscale';
  String fiscalInput = 'Codice fiscale non deve essere vuota';
  String direction = "Indirizzo di fatturazione";
  String directionInput = 'Codice fiscale non deve essere vuota';
  String province = 'Provincia';
  String citta = 'Città';
  String nazione = 'Nazione';
  String provinceInput = 'Codice fiscale non deve essere vuota';
  String capInput = 'Il CAP non deve essere vuota';
  String pecInput = 'Il PEC non deve essere vuota';
  String sdiInput = 'Il SDI non deve essere vuota';
  String save = 'Salva';
  String saveDates = 'Hai modificato i tuoi dati';
  String private = 'Sei un cliente privato?';
  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    print(lang);
    var insertDatesCast =
        await translator.translate(insertDates, from: 'it', to: lang != '' ? lang : 'it');
    var regionCast = await translator.translate(region, from: 'it', to: lang != '' ? lang : 'it');
    var regionInputCast =
        await translator.translate(regionInput, from: 'it', to: lang != '' ? lang : 'it');
    var ivaCast = await translator.translate(iva, from: 'it', to: lang != '' ? lang : 'it');
    var ivaInputCast =
        await translator.translate(ivaInput, from: 'it', to: lang != '' ? lang : 'it');
    var fiscalCast = await translator.translate(fiscal, from: 'it', to: lang != '' ? lang : 'it');
    var fiscalInputCast =
        await translator.translate(fiscalInput, from: 'it', to: lang != '' ? lang : 'it');
    var directionCast =
        await translator.translate(direction, from: 'it', to: lang != '' ? lang : 'it');
    var directionInputCast =
        await translator.translate(directionInput, from: 'it', to: lang != '' ? lang : 'it');
    var provinceCast =
        await translator.translate(province, from: 'it', to: lang != '' ? lang : 'it');
    var provinceInputCast =
        await translator.translate(provinceInput, from: 'it', to: lang != '' ? lang : 'it');
    var privateCast = await translator.translate(private, from: 'it', to: lang != '' ? lang : 'it');
    var capInputCast =
        await translator.translate(capInput, from: 'it', to: lang != '' ? lang : 'it');
    var pecInputCast =
        await translator.translate(pecInput, from: 'it', to: lang != '' ? lang : 'it');
    var sdiInputCast =
        await translator.translate(sdiInput, from: 'it', to: lang != '' ? lang : 'it');
    var saveCast = await translator.translate(save, from: 'it', to: lang != '' ? lang : 'it');
    var saveDatesCast =
        await translator.translate(saveDates, from: 'it', to: lang != '' ? lang : 'it');
    var cittaCast =
        await translator.translate(citta, from: 'it', to: lang != '' ? lang : 'it');
    var nazioneCast =
        await translator.translate(nazione, from: 'it', to: lang != '' ? lang : 'it');
    setState(() {
      insertDates = insertDatesCast.text;
      region = regionCast.text;
      regionInput = regionInputCast.text;
      iva = ivaCast.text;
      ivaInput = ivaInputCast.text;
      fiscal = fiscalCast.text;
      fiscalInput = fiscalInputCast.text;
      direction = directionCast.text;
      directionInput = directionInputCast.text;
      province = provinceCast.text;
      provinceInput = provinceInputCast.text;
      private = privateCast.text;
      capInput = capInputCast.text;
      pecInput = pecInputCast.text;
      sdiInput = sdiInputCast.text;
      save = saveCast.text;
      saveDates = saveDatesCast.text;
      nazione = nazioneCast.text;
      citta = cittaCast.text;
    });

    return false;
  }

  late FormGroup Function() buildForm;
  @override
  void initState() {
    super.initState();
    getUser(false);
    if (widget.back) {
      buildForm = () => fb.group(<String, Object>{
            'social': FormControl<String>(
              validators: [Validators.minLength(1)],
            ),
            'iva': FormControl<String>(
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
            'pec': FormControl<String>(
              validators: [Validators.minLength(1), Validators.email],
            ),
            'sdi': FormControl<String>(
              validators: [Validators.minLength(1), Validators.maxLength(5)],
            ),
            'citta': FormControl<String>(
              validators: [Validators.minLength(1)],
            ),
            'nazione': FormControl<String>(
              validators: [Validators.minLength(1)]
            ),
          });
    } else {
      buildForm = () => fb.group(<String, Object>{
            'social': FormControl<String>(
              validators: [Validators.minLength(1), Validators.required],
            ),
            'iva': FormControl<String>(
              validators: [Validators.minLength(1), Validators.required],
            ),
            'codice': FormControl<String>(
              validators: [Validators.minLength(1), Validators.required],
            ),
            'facturation': FormControl<String>(
              validators: [Validators.minLength(1), Validators.required],
            ),
            'province': FormControl<String>(
              validators: [
                Validators.minLength(1),
                Validators.maxLength(2),
                Validators.required
              ],
            ),
            'capp': FormControl<String>(
              validators: [Validators.minLength(1), Validators.required],
            ),
            'pec': FormControl<String>(
              validators: [Validators.minLength(1), Validators.required],
            ),
            'sdi': FormControl<String>(
              validators: [Validators.minLength(1), Validators.required],
            ),
            'citta': FormControl<String>(
              validators: [Validators.minLength(1)],
            ),
            'nazione': FormControl<String>(
              validators: [Validators.minLength(1)]
            ),
          });
    }
    getTranslations(currentUser.value.default_language);
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.back ? BackButton() : Text(''),
                      ],
                    ),
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
                                      widget.steps 
                                      ? 
                                      Text(
                                        insertDates ?? '',
                                        style: GoogleFonts.roboto(
                                          fontSize: 25.0,
                                          height: 1.5,
                                          color:
                                              (Colors.black),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ) : Text(''),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: widget.back
                                          ? Text('')
                                          : TextButton(
                                              
                                              onPressed: () =>
                                                  Helper.nextScreen(
                                                      context,
                                                      BillingPrivato(
                                                        scanningManual: widget
                                                            .scanningManual,
                                                        steps: widget.steps,
                                                      )),
                                              child: Text(private)),),
                                      SizedBox(height: 30,),
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
                                      Text(
                                        region,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'social',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              regionInput,
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText:
                                              currentUser.value.city_bill != ''
                                                  ? currentUser.value.city_bill
                                                  : '',
                                          helperText: '',
                                          counterText: currentUser.value.city_bill,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        iva,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'iva',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              ivaInput
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: currentUser.value.vat != ''
                                              ? currentUser.value.vat
                                              : '',
                                          helperText: '',
                                          counterText: currentUser.value.vat,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
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
                                              fiscalInput,
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
                                              directionInput,
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
                                              provinceInput,
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
                                              capInput,
                                          'unique': (_) =>
                                              'Questa e-mail è già in uso',
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
                                        height: 15.0,
                                      ),
                                      Text(
                                        "PEC",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'pec',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              pecInput,
                                          'unique': (_) =>
                                              'Questa e-mail è già in uso',
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: currentUser.value.pec != ''
                                              ? currentUser.value.pec
                                              : '',
                                          helperText: '',
                                          counterText: currentUser.value.pec,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        "SDI",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromRGBO(138, 150, 191, 1),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      ReactiveTextField<String>(
                                        formControlName: 'sdi',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              sdiInput,
                                          
                                        },
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText:
                                              currentUser.value.sdi_code != ''
                                                  ? currentUser.value.sdi_code
                                                  : '',
                                          helperText: '',
                                          counterText: currentUser.value.sdi_code,
                                          helperStyle: TextStyle(height: 0.7),
                                          errorStyle: TextStyle(height: 0.7),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 45.0,
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
                                                      'sdi_code':
                                                          form.value['sdi'] ??
                                                              currentUser.value
                                                                  .sdi_code,
                                                      'citta':
                                                          form.value['citta'] ??
                                                              currentUser.value.citta,
                                                      'nazione':
                                                          form.value['nazione'] ??
                                                              currentUser.value
                                                                  .nazione
                                                    }),
                                                    await getUser(false),
                                                    if (!widget.back)
                                                      {
                                                        Helper.nextScreen(
                                                            context,
                                                            Dashboard())
                                                      }
                                                    else
                                                      setState(() {
                                                        stateMessage =
                                                            saveDates;
                                                      }),
                                                  }
                                                else
                                                  {form.markAllAsTouched()}
                                              }),
                                      SizedBox(
                                        height: 25.0,
                                      ),
                                      
                                              SizedBox(
                                        height: 15.0,
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
