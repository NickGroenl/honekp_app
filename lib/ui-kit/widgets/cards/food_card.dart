import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/foodandbeverage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/routes/food/food_cart.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class FoodCard extends StatefulWidget {
  final FoodAndBeverageModel card;
  const FoodCard({super.key, required this.card});

  @override
  createState() => _FoodCard();
}

class _FoodCard extends State<FoodCard> {
  late bool siono = false;
  List<FoodAndBeverageModel> yourCart = currentCart.value;
  @override
  void initState() {
    super.initState();

    () async {
      final response = await http.get(
          Uri.parse("https://pds.honek.it/storage/image/${widget.card.image}"));
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            siono = true;
          });
        }
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //launchUrl(Uri.parse('https://es.wikipedia.org/wiki/Venecia'));
      },
      child: AbsorbPointer(
          absorbing: widget.card.status == 0 ? true : false,
          child: Opacity(opacity: widget.card.status == 0 ? 0.5 : 1,
          child: Container(
            height: ScreenUtil().setHeight(300.0),
            width: ScreenUtil().setWidth(200.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Color(0xFFF4F5F6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                siono
                    ? Expanded(
                        child: Image.network(
                          "https://pds.honek.it/storage/image/${widget.card.image}",
                          fit: BoxFit.contain,
                          width: 255,
                        ),
                      )
                    : Expanded(
                                      child: SizedBox(
                                          width: 255,
                                          ),
                                    ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.card.name,
                        style: GoogleFonts.roboto(
                          fontSize: 19.0,
                          color: Color.fromRGBO(33, 45, 82, 1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        widget.card.nameStructure,
                        style: GoogleFonts.roboto(
                          fontSize: 15.0,
                          color: Color.fromARGB(255, 92, 93, 95),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.0),
                          child: Row(children: [
                            Text(
                              "€${widget.card.price}",
                              style: GoogleFonts.roboto(
                                fontSize: 20.0,
                                height: 1.5,
                                color: Color.fromARGB(255, 27, 133, 62),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () => {
                                  yourCart.add(widget.card),
                                  currentCart.value = yourCart,
                                  Helper.nextScreen(
                                  context,
                                  ShopCart(
                                    yourCart: [...currentCart.value],
                                  ))
                                },
                                child: Row(children: [
                                  
                                  Icon(
                                    Ionicons.add_outline,
                                    size: 25,
                                    color: Constants.primaryColor,
                                  ),
                                ]))
                          ])),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))),
    );
  }
}
