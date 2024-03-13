import 'package:newhonekapp/app/models/foodandbeverage.dart';
import 'package:newhonekapp/app/models/travels.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/routes/food/food_list.dart';
import 'package:newhonekapp/app/static/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';

class CategoryCards extends StatefulWidget {
  final CategoriesModel categories;
  const CategoryCards(this.categories, {super.key});

  @override
  createState() => _CategoryCards();
}

class _CategoryCards extends State<CategoryCards> {
  late List<FoodAndBeverageModel> datatoFoodList = [];
  @override
  void initState() {
    super.initState();
    late List<FoodAndBeverageModel> rss = [];
    for (var i = 0; i < currentBeverages.value.length; i++) {
      if (CategoriesData.categories.indexOf(widget.categories)+1 ==
          currentBeverages.value[i].idcategory) {
        rss.add(currentBeverages.value[i]);
      }
    }
    setState(() {
      datatoFoodList = rss;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Helper.nextScreen(
            context,
            FoodList(
              datas: [...datatoFoodList],
            )),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(widget.categories.title,
                style: GoogleFonts.roboto(fontSize: 17)),
          ),
        ));
  }
}
