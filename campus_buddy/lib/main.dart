import 'package:campus_buddy/screens/mainPage.dart';
import 'package:campus_buddy/theme/theme.dart';
import 'package:flutter/material.dart';

import 'Utils/SizeConfig.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
