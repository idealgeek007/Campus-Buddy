import 'package:campus_buddy/Utils/SizeConfig.dart';
import 'package:campus_buddy/Utils/textStylse.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Card card1(String text, String imageUrl, double size, Color color,
    BuildContext context) {
  return Card(
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
              style: kbody(context)
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
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
  );
}
