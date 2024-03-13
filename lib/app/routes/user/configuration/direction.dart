import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/ui-kit/widgets/forms/dropdown.dart';
import 'package:newhonekapp/ui-kit/widgets/primary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';
import '../../../models/user.dart';
import '../../../repository/constants.dart';
import '../../../repository/user.dart';

class DirectionConfiguration extends StatefulWidget {
  const DirectionConfiguration({super.key});

  @override
  createState() => _DirectionConfiguration();
}

class _DirectionConfiguration extends State<DirectionConfiguration> {
  String stateMessage = '';
  int placeCountry = currentUser.value.country_id.toInt();
  int placeProvince = currentUser.value.province_id.toInt();
  String direction = 'Indirizzo';
  String directionInput = "Il indirizzo non deve essere vuota";
  String capInput = "Il indirizzo non deve essere vuota";
  String province = "Provincia";
  String country = 'Nazione';
  String saveDates = 'Hai modificato i tuoi dati';
  String save = 'Salva';
  final translator = GoogleTranslator();

  getTranslations(String lang) async {
    var directionCast =
        await translator.translate(direction, from: 'it', to: lang);
    var directionInputCast =
        await translator.translate(directionInput, from: 'it', to: lang);
    var capInputCast =
        await translator.translate(capInput, from: 'it', to: lang);
    var provinceCast =
        await translator.translate(province, from: 'it', to: lang);
    var countryCast = await translator.translate(country, from: 'it', to: lang);
    var saveDatesCast =
        await translator.translate(saveDates, from: 'it', to: lang);
    var saveCast = await translator.translate(save, from: 'it', to: lang);

    setState(() {
      direction = directionCast.text;
      directionInput = directionInputCast.text;
      capInput = capInputCast.text;
      province = provinceCast.text;
      country = countryCast.text;
      saveDates = saveDatesCast.text;
      save = saveCast.text;
    });

    return false;
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'direction': FormControl<String>(
          validators: [Validators.minLength(3)],
        ),
        'cap': FormControl<String>(
          validators: [Validators.minLength(3)],
        ),
      });
  @override
  void initState() {
    super.initState();
    getTranslations(currentUser.value.default_language);
    // ignore: use_build_context_synchronousl

    if ((currentUser.value.country_id.toInt() - 1 > countrieList.length) ||
        (currentUser.value.country_id.toInt() - 1 < 0)) {
      currentUser.value.country_id = countrieList.length;
    }
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
                          child: ValueListenableBuilder(
                            builder:
                                (BuildContext context, value, Widget? child) {
                              return Column(
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
                                              direction,
                                              style: GoogleFonts.roboto(
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    138, 150, 191, 1),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            ReactiveTextField<String>(
                                              formControlName: 'direction',
                                              validationMessages: {
                                                ValidationMessage.required:
                                                    (_) => directionInput
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                helperText: '',
                                                labelText:
                                                    currentUser.value.address,
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
                                              "CAP",
                                              style: GoogleFonts.roboto(
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    138, 150, 191, 1),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            ReactiveTextField<String>(
                                              formControlName: 'cap',
                                              validationMessages: {
                                                ValidationMessage.required:
                                                    (_) => capInput
                                              },
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                helperText: '',
                                                labelText:
                                                    currentUser.value.zip,
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
                                              province,
                                              style: GoogleFonts.roboto(
                                                fontSize: 14.0,
                                                color: Color.fromRGBO(
                                                    138, 150, 191, 1),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            AppDropdownInput(
                                              hintText: province,
                                              options: currentUser
                                                              .value.country_id
                                                              .toInt() -
                                                          1 ==
                                                      0
                                                  ? provinceList[currentUser
                                                              .value.country_id
                                                              .toInt() -
                                                          1]
                                                      .map((e) => e)
                                                      .toList()
                                                  : ["Qualunque"],
                                              value: currentUser
                                                              .value.country_id
                                                              .toInt() -
                                                          1 ==
                                                      0
                                                  ? provinceList[currentUser
                                                          .value.country_id
                                                          .toInt() -
                                                      1][currentUser
                                                          .value.province_id
                                                          .toInt() -
                                                      1]
                                                  : "Qualunque",
                                              getLabel: (String value) => value,
                                              onChanged: (value) => {
                                                setState(() {
                                                  placeProvince = currentUser
                                                                  .value
                                                                  .country_id
                                                                  .toInt() -
                                                              1 ==
                                                          0
                                                      ? provinceList[currentUser
                                                                  .value
                                                                  .country_id
                                                                  .toInt() -
                                                              1]
                                                          .indexOf(value!)
                                                      : 0;
                                                })
                                              },
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            Text(
                                              country,
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
                                              hintText: country,
                                              options: countrieList
                                                  .map((e) => e)
                                                  .toList(),
                                              value: countrieList[currentUser
                                                      .value.country_id
                                                      .toInt() -
                                                  1],
                                              getLabel: (String value) => value,
                                              onChanged: (value) => {
                                                setState(() {
                                                  placeCountry = countrieList
                                                      .indexOf(value!);
                                                })
                                              },
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
                                              height: 15.0,
                                            ),
                                            PrimaryButton(
                                              onPressed: () async => {
                                                if (form.valid)
                                                  {
                                                    if (await updateAddress({
                                                      'address': form.value[
                                                              'direction'] ??
                                                          currentUser
                                                              .value.address,
                                                      'zip': form
                                                              .value['cap'] ??
                                                          currentUser.value.zip,
                                                      'country_id':
                                                          placeCountry == 0
                                                              ? 1
                                                              : placeCountry,
                                                      'province_id':
                                                          placeProvince == 0
                                                              ? 1
                                                              : placeProvince
                                                    }))
                                                      {
                                                        setState(() {
                                                          stateMessage =
                                                              saveDates;
                                                        })
                                                      }
                                                    else
                                                      {
                                                        setState(() {
                                                          stateMessage =
                                                              'Cè stato un problema';
                                                        })
                                                      }
                                                  }
                                                else
                                                  {form.markAllAsTouched()}
                                              },
                                              text: save,
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
                              );
                            },
                            valueListenable: currentUser,
                          ))),
                ],
              ),
            ),
          );
        });
  }
}
