import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InlineCard extends StatelessWidget {
  // Our primary button widget [to be reused]
  final Function onPressed;
  final String text;
  final IconData iconFirst;
  final IconData iconFinal;
  const InlineCard(
      {super.key,
      required this.iconFirst,
      required this.text,
      required this.onPressed,
      required this.iconFinal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 23.0),
          child: Row(children: [
            Icon(iconFirst, size: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                text,
                style: GoogleFonts.roboto(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 88, 90, 97),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(),
            Icon(iconFinal)
          ]
        )
      ),
    );
  }
}
