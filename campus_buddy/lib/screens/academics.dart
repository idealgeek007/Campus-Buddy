import 'package:campus_buddy/components/appbar.dart';
import 'package:campus_buddy/components/card3.dart';
import 'package:campus_buddy/screens/attendance/attendance.dart';
import 'package:flutter/material.dart';

import '../Utils/SizeConfig.dart';
import 'MarkaTracker/view.dart';
import 'Resources/resourcesWebview.dart';
import 'TimeTable/timetable.dart';

class AcademicsPage extends StatelessWidget {
  const AcademicsPage({super.key});
  void _openWebView(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(url: url),
      ),
    );
  }

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
                    imageUrl: 'assets/images/c3Images/timetable.png',
                    title: 'TimeTable',
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TimeTables())),
                  ),
                  AcaCardStack(
                    top: -10,
                    left: 0,
                    right: -100,
                    bottom: -20,
                    imageUrl: 'assets/images/c3Images/resources.png',
                    title: 'Resources',
                    onTap: () {
                      _openWebView(context,
                          'https://sdmcselibrary.blogspot.com/p/home.html');
                    },
                  ),
                  AcaCardStack(
                    top: -10,
                    left: 0,
                    right: -100,
                    bottom: -20,
                    imageUrl: 'assets/images/c3Images/IA.png',
                    title: 'Marks Tracker',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MarksOverview(),
                      ),
                    ),
                  ),
                  AcaCardStack(
                    top: -10,
                    left: 0,
                    right: -100,
                    bottom: -20,
                    imageUrl: 'assets/images/c3Images/tt.png',
                    title: 'Attendance',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendanceTracker(),
                      ),
                    ),
                  ),
                  AcaCardStack(
                    top: -10,
                    left: 0,
                    right: -110,
                    bottom: -20,
                    imageUrl: 'assets/images/c3Images/assignements.png',
                    title: 'Assignments',
                    onTap: () {},
                  ),
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
    required this.onTap,
  });

  final double top;
  final double bottom;
  final double left;
  final double right;
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
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
      ),
    );
  }
}
