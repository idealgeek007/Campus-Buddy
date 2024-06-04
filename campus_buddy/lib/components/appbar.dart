import 'package:campus_buddy/Utils/textStylse.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final double appBarHeight;

  const MyAppBar({
    Key? key,
    required this.title,
    this.leading,
    required this.actions,
    this.appBarHeight = kToolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Row(
        children: [
          if (leading != null) leading!,
          if (leading != null) SizedBox(width: 10),
          Text(
            title,
            style: ksubHead(context).copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        if (actions.isNotEmpty) ...actions,
        if (leading != null && actions.isNotEmpty) SizedBox(width: 10),
      ],
      toolbarHeight: appBarHeight,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
