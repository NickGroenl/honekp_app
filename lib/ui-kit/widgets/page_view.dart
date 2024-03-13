import 'package:newhonekapp/app/routes/user/login.dart';
import 'package:newhonekapp/ui-kit/utils/constants.dart';
import 'package:newhonekapp/ui-kit/utils/helper.dart';
import 'package:newhonekapp/ui-kit/widgets/navigation/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageViewTemplate extends StatelessWidget {
  final int activePage;
  final String imagePath;
  final String title;
  final String textDescription;

  const PageViewTemplate(
      {super.key,
      required this.activePage,
      required this.imagePath,
      required this.title,
      required this.textDescription});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(70),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      imagePath,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                      fontSize: 26.0,
                      height: 1.5,
                      color: Color.fromARGB(255, 71, 80, 106),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: Text(
                      textDescription,
                      style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 129, 130, 131),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Center(
              child: Row(
            children: <Widget>[
              SizedBox(width: 25),
              TextButton(
                onPressed: () => Helper.nextScreen(context, Login()),
                child: Text(
                  "Salta",
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 10),
              PageIndicator(activePage: activePage),
            ],
          )),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }
}
