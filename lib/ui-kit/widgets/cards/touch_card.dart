import 'package:newhonekapp/app/models/travels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TouchCard extends StatelessWidget {
  final TravelsModel card;
  const TouchCard({super.key, required this.card});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //launchUrl(Uri.parse('https://es.wikipedia.org/wiki/Venecia'));
      },
      child: Container(
        height: ScreenUtil().setHeight(300.0),
        width: ScreenUtil().setWidth(255.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      
                      card.imagepath,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.title,
                    style: GoogleFonts.roboto(
                      fontSize: 16.0,
                      color: Color.fromRGBO(33, 45, 82, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    card.description,
                    style: GoogleFonts.roboto(
                      fontSize: 13.0,
                      color: Color.fromRGBO(138, 150, 190, 1),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
