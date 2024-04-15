import 'package:campus_buddy/components/appbar.dart';
import 'package:campus_buddy/components/card3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AcademicsPage extends StatelessWidget {
  const AcademicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Academics', actions: []),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardType3('TimeTable', context, Colors.blueGrey),
                  cardType3('TimeTable', context, Colors.blueGrey),
                  cardType3('TimeTable', context, Colors.blueGrey),
                  cardType3('TimeTable', context, Colors.blueGrey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
