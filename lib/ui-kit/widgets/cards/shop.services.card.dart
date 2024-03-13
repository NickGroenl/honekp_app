import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/foodandbeverage.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/app/models/services.model.dart';
import 'package:newhonekapp/app/routes/food/food_cart.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ShopCardServices extends StatefulWidget {
  final ServicesModel card;
  const ShopCardServices({super.key, required this.card});

  @override
  createState() => _ShopCardServices();
}

class _ShopCardServices extends State<ShopCardServices> {
  late bool siono = false;
  List<ServicesModel> rss = currentServicesCart.value;
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
    return WillPopScope(
        onWillPop: () async => true,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Color.fromRGBO(229, 229, 229, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        color: Color.fromRGBO(229, 229, 229, 1),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              siono
                                  ? Expanded(
                                      child: Image.network(
                                          "https://pds.honek.it/storage/image/${widget.card.image}",
                                          fit: BoxFit.contain,
                                          width: 50,
                                          height: 50),
                                    )
                                  : Expanded(
                                      child: SizedBox(width: 50, height: 50),
                                    ),
                              Expanded(
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          widget.card.name,
                                          style: GoogleFonts.roboto(
                                            fontSize: 19.0,
                                            color:
                                                Color.fromRGBO(33, 45, 82, 1),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                            child: Row(children: [
                                              Text(
                                                "€${widget.card.price}",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 20.0,
                                                  height: 1.5,
                                                  color: Color.fromARGB(
                                                      255, 27, 133, 62),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ])),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    )),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () => {
                                    rss.remove(widget.card),
                                    currentServicesCart.value = rss,
                                    Helper.nextScreen(
                                        context,
                                        ShopCart(
                                          yourCart: [...currentCart.value],
                                        ))
                                  },
                                  child: Icon(
                                    Ionicons.trash_outline,
                                    size: 25,
                                    color: Constants.errorColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
