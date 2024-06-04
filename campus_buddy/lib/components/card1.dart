import 'package:campus_buddy/Utils/SizeConfig.dart';
import 'package:campus_buddy/Utils/textStylse.dart';
import 'package:campus_buddy/screens/club/club_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

GestureDetector card1(String text, String imageUrl, double size, Color color,
    BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClubPage(),
        ),
      );
    },
    child: Card(
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                text,
                style: kbody(context).copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8.0),
                ),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
