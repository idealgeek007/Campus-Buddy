import 'package:flutter/material.dart';

import '../components/appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBar(title: 'Settings', actions: []),
        body: Center(
          child: Text(
            "Settings Page",
            style: TextStyle(fontSize: 42),
          ),
        ));
  }
}
