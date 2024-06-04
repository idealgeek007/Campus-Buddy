import 'package:campus_buddy/authentication/authgate.dart';
import 'package:campus_buddy/provider/user_provider.dart';
import 'package:campus_buddy/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Utils/SizeConfig.dart'; // Make sure to import provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Campus Buddy',
        theme: lightTheme, // Correctly define or use your theme variable
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: AuthGate(),
      ),
    );
  }
}
