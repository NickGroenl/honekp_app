import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/foodandbeverage.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/routes/food/food_cart.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/cards/food_card_list.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:translator/translator.dart';

class FoodList extends StatefulWidget {
  final List<FoodAndBeverageModel> datas;
  const FoodList({super.key, required this.datas});

  @override
  createState() => _FoodList();
}

class _FoodList extends State<FoodList> {
  List<FoodAndBeverageModel> listFoodStatic = [];
  final translator = GoogleTranslator();
  String dontDates = 'Non hai dati disponibile.';

  getTransalations(String lang) async {
    var dontDatesCast =
        await translator.translate(dontDates, from: 'it', to: lang);
    setState(() {
      dontDates = dontDatesCast.text;
    });

    return false;
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        'searcher': FormControl<String>(
          validators: [Validators.required],
        ),
      });
  void filtlerFoods(String text) {
    List<FoodAndBeverageModel> moments = [];
    for (var item in listFoodStatic) {
      if (item.name.toLowerCase().contains(text.toLowerCase())) {
        moments.add(item);
      }
    }
    if (moments.isEmpty || text.isEmpty) {
      moments = [...widget.datas];
    }
    setState(() {
      listFoodStatic = [...moments];
    });
  }

  @override
  void initState() {
    super.initState();
    getTransalations(currentUser.value.default_language);
    Future.delayed(Duration.zero, () async {
      setState(() {
        listFoodStatic = [...widget.datas];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      builder: (BuildContext context, FormGroup formGroup, Widget? child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SafeArea(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(),
                      Spacer(),
                      InkWell(
                          onTap: () => Helper.nextScreen(
                              context,
                              ShopCart(
                                yourCart: [...currentCart.value],
                              )),
                          child: SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child: Icon(Ionicons.cart_outline,
                                size: 25, color: Constants.primaryColor),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReactiveTextField<String>(
                    formControlName: 'searcher',
                    onChanged: (control) => filtlerFoods(control.value!),
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Ionicons.search_outline),
                      labelText: '',
                      helperText: '',
                      helperStyle: TextStyle(height: 0.7),
                      errorStyle: TextStyle(height: 0.7),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                listFoodStatic.isNotEmpty
                    ? Column(children: [
                        ListView.builder(
                          padding: const EdgeInsets.all(0),
                          // make sure to add the following lines:
                          shrinkWrap: true,
                          physics: ScrollPhysics(),

                          itemBuilder: (BuildContext context, int index) {
                            return FoodCardList(card: listFoodStatic[index]);
                          },
                          itemCount: listFoodStatic.length,
                          // the rest of your list view code
                        ) // ListView
                      ])
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          dontDates,
                          style: GoogleFonts.roboto(
                            fontSize: 18.0,
                            height: 1.5,
                            color: Color.fromARGB(255, 76, 79, 90),
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                SizedBox(height: 35),
              ],
            ),
          ),
        );
      },
      form: buildForm,
    );
  }
}
