import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/foodandbeverage.dart';
import 'package:newhonekapp/app/models/services.model.dart';
import 'package:newhonekapp/app/models/shop.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/services.dart';
import 'package:newhonekapp/app/repository/shop.dart';
import 'package:newhonekapp/app/routes/food/food_cart.dart';
import 'package:newhonekapp/app/routes/food/food_list.dart';
import 'package:newhonekapp/app/routes/services/services.list.dart';
import 'package:newhonekapp/app/routes/services/servicies.cart.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/services.card.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/shop_card_list.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  createState() => _Services();
}

class _Services extends State<Services> {
  final translator = GoogleTranslator();
  String viewAll = 'Vedi tutto';
  String convenzionati = "Convenzionati";
  String dontConvenzionati = "Non ci sono locali convenzionati";
  String sugeriti = "Suggeriti";
  String dontSugeriti = 'Non ci sono locali suggeriti';

  getTranslations(String lang) async {
    print(lang);
    if(lang.isEmpty){
      lang = 'it';
    }
    var viewAllCast = await translator.translate(viewAll, from: 'it', to: lang);
    var convenzionatiCast =
        await translator.translate(convenzionati, from: 'it', to: lang);
    var dontConvenzionatiCast =
        await translator.translate(dontConvenzionati, from: 'it', to: lang);
    var sugeritiCast =
        await translator.translate(sugeriti, from: 'it', to: lang);
    var dontSugeritiCast =
        await translator.translate(dontSugeriti, from: 'it', to: lang);
    
    setState(() {
      viewAll = viewAllCast.text;
      convenzionati = convenzionatiCast.text;
      dontConvenzionati = dontConvenzionatiCast.text;
      sugeriti = sugeritiCast.text;
      dontSugeriti = dontSugeritiCast.text;
    });

    return false;
  }

  Future<void> getData() async {
    await getShopsServices();
  }

  @override
  void initState() {
    super.initState();
    getTranslations(currentUser.value.default_language);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(pageActually: "services"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Spacer(),
                  Text(
                    "Local services",
                    style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      height: 1.5,
                      color: Color.fromARGB(255, 71, 80, 106),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  /*InkWell(
                      onTap: () => Helper.nextScreen(
                          context,
                          ShopCartServices(
                            yourCart: [...currentServicesCart.value],
                          )),
                      child: SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: Icon(
                          Ionicons.cart_outline,
                          size: 25,
                          color: Constants.primaryColor,
                        ),
                      )),*/
                      Spacer()
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(children: [
                  Text(
                    convenzionati,
                    style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      height: 1.5,
                      color: Color.fromARGB(255, 71, 80, 106),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () => Helper.nextScreen(
                          context,
                          ServicesList(
                            datas: [...currentServices.value],
                            isSuggeriti: false,
                          )),
                      child: Row(children: [
                        Text(viewAll,
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: Constants.primaryColor)),
                        Icon(
                          Ionicons.arrow_forward_outline,
                          size: 16,
                          color: Constants.primaryColor,
                        ),
                      ]))
                ])),
            SizedBox(
              height: 15.0,
            ),
            ValueListenableBuilder(
              valueListenable: currentServicesPriority,
              builder: (BuildContext context, value, Widget? child) {
                return currentServicesPriority.value.isNotEmpty
                    ? SizedBox(
                        height: ScreenUtil().setHeight(300.0),
                        // Lets create a model to structure property data
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            // Lets create a property card widget
                            return ServicesCard(
                              suggeriti: false,
                              card: currentServicesPriority.value[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10.0,
                            );
                          },
                          // Make the length our static data length
                          itemCount: currentServicesPriority.value.length > 5
                              ? 5
                              : currentServicesPriority.value.length,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          dontConvenzionati,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 76, 79, 90),
                            fontWeight: FontWeight.w400,
                          ),
                        ));
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(children: [
                  Text(
                    sugeriti,
                    style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      height: 1.5,
                      color: Color.fromARGB(255, 71, 80, 106),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () => Helper.nextScreen(
                          context,
                          ServicesList(
                            datas: [...currentServices.value],
                            isSuggeriti: true,
                          )),
                      child: Row(children: [
                        Text(viewAll,
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: Constants.primaryColor)),
                        Icon(
                          Ionicons.arrow_forward_outline,
                          size: 16,
                          color: Constants.primaryColor,
                        ),
                      ]))
                ])),
            SizedBox(
              height: 15,
            ),
            ValueListenableBuilder(
              valueListenable: currentServicesNoPay,
              builder: (BuildContext context, value, Widget? child) {
                return currentServicesNoPay.value.isNotEmpty
                    ? SizedBox(
                        height: ScreenUtil().setHeight(300.0),
                        // Lets create a model to structure property data
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            // Lets create a property card widget
                            return ServicesCard(
                              suggeriti: true,
                              card: currentServicesNoPay.value[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10.0,
                            );
                          },
                          // Make the length our static data length
                          itemCount: currentServicesNoPay.value.length > 5
                              ? 5
                              : currentServicesNoPay.value.length,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          dontSugeriti,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 76, 79, 90),
                            fontWeight: FontWeight.w400,
                          ),
                        ));
              },
            ),
            SizedBox(
              height: 20,
            ),
            /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        recently,
                        style: GoogleFonts.roboto(
                          fontSize: 20.0,
                          height: 1.5,
                          color: Color.fromARGB(255, 71, 80, 106),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                    ])),
            ValueListenableBuilder(
              valueListenable: currentShopsServices,
              builder: (BuildContext context, value, Widget? child) {
                return Column(children: [
                  ListView.builder(
                    padding: const EdgeInsets.all(8),
                    // make sure to add the following lines:
                    shrinkWrap: true,
                    physics: ScrollPhysics(),

                    itemBuilder: (BuildContext context, int index) {
                      return ShopCardList(
                          card: currentShopsServices.value[index]);
                    },
                    itemCount: currentShopsServices.value.length,
                    // the rest of your list view code
                  ) // ListView
                ]);
              },
            ),*/
          ],
        ),
      ),
    );
  }
}
