import 'package:campus_buddy/components/appbar.dart';
import 'package:campus_buddy/components/card3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Utils/SizeConfig.dart';

class AcademicsPage extends StatelessWidget {
  const AcademicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
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
                  AcaCardStack(
                    top: 40,
                    bottom: -10,
                    left: 10,
                    right: -170,
                    imageUrl: 'assets/images/c3Images/attendance2.png',
                    title: 'TimeTable',
                  ),
                  AcaCardStack(
                      top: -10,
                      left: 0,
                      right: -100,
                      bottom: -20,
                      imageUrl: 'assets/images/c3Images/resources.png',
                      title: 'Resources'),
                  AcaCardStack(
                      top: -10,
                      left: 0,
                      right: -100,
                      bottom: -20,
                      imageUrl: 'assets/images/c3Images/IA.png',
                      title: 'Marks Tracker'),
                  AcaCardStack(
                      top: -10,
                      left: 0,
                      right: -100,
                      bottom: -20,
                      imageUrl: 'assets/images/c3Images/tt.png',
                      title: 'Attendance'),
                  AcaCardStack(
                      top: -10,
                      left: 0,
                      right: -110,
                      bottom: -20,
                      imageUrl: 'assets/images/c3Images/assignements.png',
                      title: 'Assignments'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AcaCardStack extends StatelessWidget {
  const AcaCardStack({
    super.key,
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
    required this.imageUrl,
    required this.title,
  });

  final double top;
  final double bottom;
  final double left;
  final double right;
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        cardType3(
          title,
          context,
          Theme.of(context).colorScheme.secondary,
        ),
        Positioned(
          top: top, //-10
          left: left, //0
          right: right, //-100
          bottom: bottom, //-20
          child: Image.asset(
            imageUrl,
            width: SizeConfig.screenWidth * 0.5,
          ),
        ),
      ],
    );
  }
}
