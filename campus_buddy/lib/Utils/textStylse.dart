import 'package:campus_buddy/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var size = SizeConfig.screenWidth / 10;

TextStyle kheading(BuildContext context) => GoogleFonts.poppins(
      fontSize: SizeConfig.screenWidth / 10,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onSurface,
    );

TextStyle ksubHead(BuildContext context) => GoogleFonts.poppins(
      fontSize: SizeConfig.screenWidth / 20,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).colorScheme.onSurface,
    );

TextStyle kbody(BuildContext context) => GoogleFonts.poppins(
      fontSize: SizeConfig.screenWidth / 20,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).colorScheme.onSurface,
    );
