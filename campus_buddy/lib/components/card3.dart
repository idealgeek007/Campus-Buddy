import 'package:campus_buddy/Utils/textStylse.dart';
import 'package:flutter/material.dart';

Padding cardType3(String text, BuildContext context, Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 40),
    child: Card(
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).width * 0.5,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10),
          child: Text(
            text,
            style: ksubHead(context).copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ),
  );
}
