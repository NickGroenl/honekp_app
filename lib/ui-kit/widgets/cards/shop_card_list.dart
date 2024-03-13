import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:newhonekapp/app/models/shop.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ShopCardList extends StatefulWidget {
  final ShopsModel card;
  const ShopCardList({super.key, required this.card});

  @override
  createState() => _ShopCardList();
}

class _ShopCardList extends State<ShopCardList> {
  late bool siono = false;
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
    return AbsorbPointer(
        absorbing: true,
        child: Opacity(
            opacity: 0.5,
            child: Padding(
              
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color.fromARGB(0, 255, 255, 255),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                            child: IntrinsicHeight(
                              child: Row(
                                
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  siono
                                      ? Expanded(
                                          child: Image.network(
                                            "https://pds.honek.it/storage/image/${widget.card.image}",
                                            fit: BoxFit.contain,
                                            width: 150,
                                            height: 100,
                                          ),
                                        )
                                      : Expanded(child: Text('')),
                                  Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              widget.card.title,
                                              style: GoogleFonts.roboto(
                                                fontSize: 19.0,
                                                color: Color.fromRGBO(
                                                    33, 45, 82, 1),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.0),
                                                    child: Row(children: [
                                                      Text(
                                                        "€${widget.card.price}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 20.0,
                                                          height: 1.5,
                                                          color: Color.fromARGB(
                                                              255, 27, 133, 62),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      
                                                    ])),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        
                      
                    )))));
  }
}
