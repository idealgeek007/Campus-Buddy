import 'package:flutter/material.dart';

Card cardType3(String text, BuildContext context, Color color) {
  return Card(
    shadowColor: Theme.of(context).colorScheme.shadow,
    color: color,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).width * 0.5,
      ),
    ),
  );
}
