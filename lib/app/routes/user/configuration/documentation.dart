import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/models/user.dart';
import 'package:newhonekapp/app/repository/constants.dart';

class DocumentationView extends StatelessWidget {
  const DocumentationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(bottom:false, child: SizedBox()),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.map_outline,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      currentUser.value.placebirth,
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Icon(
                                      Ionicons.document_outline,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "#${currentUser.value.number_document}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20.0,
                                        color: Color.fromRGBO(138, 150, 191, 1),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                

                                SizedBox(
                                  height: 25.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(currentUser.value.front_image != '' ? "$baseUrl/${currentUser.value.front_image}" : ''),
                                    ),
                                )),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(currentUser.value.back_image != '' ? "$baseUrl/${currentUser.value.back_image}" : ''),
                                    ),
                                )),
                                SizedBox(
                                  height: 25.0,
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
  }
}
