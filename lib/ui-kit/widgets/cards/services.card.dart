import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newhonekapp/app/models/services.model.dart';
import 'package:newhonekapp/app/routes/services/servicies.cart.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ServicesCard extends StatefulWidget {
  final bool suggeriti = false;
  final ServicesModel card;
  const ServicesCard({super.key, required this.card, required bool suggeriti});

  @override
  createState() => _ServicesCard();
}

class _ServicesCard extends State<ServicesCard> {
  late bool siono = false;
  List<ServicesModel> yourCart = currentServicesCart.value;
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
          child: Opacity(
              opacity: widget.card.status == 0 ? 0.5 : 1,
              child: Container(
                height: ScreenUtil().setHeight(300.0),
                width: ScreenUtil().setWidth(250.0),
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
                            widget.card.description,
                            style: GoogleFonts.roboto(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 92, 93, 95),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                              child: Row(
                                children: [
                                  Icon(Ionicons.location_outline),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.card.address,
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.0,
                                      color: Color.fromARGB(255, 42, 77, 158),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () async =>
                                  await launchUrl(Uri.parse(widget.card.map))),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(Ionicons.call_outline),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.card.phone,
                                style: GoogleFonts.roboto(
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 90, 93, 100),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          widget.card.type == 'suggestion' ? Text('') : 
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
                                widget.card.type == 'suggestion'
                                    ? Text('')
                                    : InkWell(
                                        onTap: () => {
                                              yourCart.add(widget.card),
                                              currentServicesCart.value =
                                                  yourCart,
                                              Helper.nextScreen(
                                                  context,
                                                  ShopCartServices(
                                                    yourCart: [
                                                      ...currentServicesCart
                                                          .value
                                                    ],
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
