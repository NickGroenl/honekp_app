import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/foodandbeverage.dart';
import 'package:newhonekapp/app/models/shop.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/routes/dashboard/dashboard.dart';
import 'package:newhonekapp/app/routes/food/food_cart.dart';
import 'package:newhonekapp/app/routes/food/food_list.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/category_cards.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/shop_card_list.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/app_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../../../ui-kit/widgets/cards/food_card.dart';
import '../../static/constants.dart';

class Food extends StatefulWidget {
  const Food({super.key});

  @override
  createState() => _Food();
}

class _Food extends State<Food> {
  final translator = GoogleTranslator();
  String viewAll = 'Vedi tutto';
  String dontRoom = "Non hai room service in corso";
  String getRecent = "Acquistati di recente";
  getTransalations(String lang) async {
    var viewAllCast = await translator.translate(viewAll, from: 'it', to: lang);
    var dontRoomCast =
        await translator.translate(dontRoom, from: 'it', to: lang);
    var getRecentCast =
        await translator.translate(getRecent, from: 'it', to: lang);
    setState(() {
      viewAll = viewAllCast.text;
      dontRoom = dontRoomCast.text;
      getRecent = getRecentCast.text;
    });

    return false;
  }

  @override
  void initState() {
    super.initState();
    getTransalations(currentUser.value.default_language);
    Future.delayed(Duration.zero, () async {
      List<FoodAndBeverageModel> frigobarFast = [];
      List<FoodAndBeverageModel> barFast = [];
      for (var i = 0; i < currentFoods.value.length; i++) {
        if (currentFoods.value[i].salefrigobar == 1) {
          frigobarFast.add(currentFoods.value[i]);
        }
        if (currentFoods.value[i].salebar == 1) {
          barFast.add(currentFoods.value[i]);
        }
      }
      for (var e = 0; e < currentBeverages.value.length; e++) {
        if (currentBeverages.value[e].salefrigobar == 1) {
          frigobarFast.add(currentBeverages.value[e]);
        }
        if (currentBeverages.value[e].salebar == 1) {
          barFast.add(currentBeverages.value[e]);
        }
      }
      currentBarSale.value = barFast;
      currentFrigoBarSale.value = frigobarFast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: AppBottomNavigation(pageActually: "food"),
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
                      BackButton(
                        onPressed: () =>
                            Helper.nextScreen(context, Dashboard()),
                      ),
                      Text(
                        "Food & Beverage",
                        style: GoogleFonts.roboto(
                          fontSize: 20.0,
                          height: 1.5,
                          color: Color.fromARGB(255, 71, 80, 106),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                          onTap: () => Helper.nextScreen(
                              context,
                              ShopCart(
                                yourCart: [...currentCart.value],
                              )),
                          child: SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child: Icon(
                              Ionicons.cart_outline,
                              size: 25,
                              color: Constants.primaryColor,
                            ),
                          )),
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
                        "Room service",
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
                              FoodList(
                                datas: [...currentFrigoBarSale.value],
                              )),
                          child: Row(children: [
                            Text(viewAll,
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Constants.primaryColor)),
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
                  valueListenable: currentFrigoBarSale,
                  builder: (BuildContext context, value, Widget? child) {
                    return currentFrigoBarSale.value.isNotEmpty
                        ? SizedBox(
                            height: ScreenUtil().setHeight(300.0),
                            // Lets create a model to structure property data
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                // Lets create a property card widget
                                return FoodCard(
                                  card: currentFrigoBarSale.value[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 10.0,
                                );
                              },
                              // Make the length our static data length
                              itemCount: currentFrigoBarSale.value.length > 5
                                  ? 5
                                  : currentFrigoBarSale.value.length,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              dontRoom,
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
                  height: 15.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    itemBuilder: (BuildContext context, int index) {
                      // Lets create a property card widget
                      return CategoryCards(
                        CategoriesData.categories[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 0.0,
                      );
                    },
                    // Make the length our static data length
                    itemCount: CategoriesData.categories.length,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            getRecent,
                            style: GoogleFonts.roboto(
                              fontSize: 20.0,
                              height: 1.5,
                              color: Color.fromARGB(255, 71, 80, 106),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ])),
                ValueListenableBuilder(
                  valueListenable: currentShops,
                  builder: (BuildContext context, value, Widget? child) {
                    return Column(children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(8),
                        // make sure to add the following lines:
                        shrinkWrap: true,
                        physics: ScrollPhysics(),

                        itemBuilder: (BuildContext context, int index) {
                          return ShopCardList(card: currentShops.value[index]);
                        },
                        itemCount: currentShops.value.length,
                        // the rest of your list view code
                      ) // ListView
                    ]);
                  },
                ),
              ]),
        ));
  }
}
