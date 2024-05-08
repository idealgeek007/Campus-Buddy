import 'package:campus_buddy/Utils/SizeConfig.dart';
import 'package:campus_buddy/Utils/textStylse.dart';
import 'package:campus_buddy/components/appbar.dart';
import 'package:campus_buddy/components/circularAvatar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;

    return Scaffold(
      appBar: MyAppBar(title: 'Profile', actions: []),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    MyCircularAvatar(
                      radius: SizeConfig.screenWidth * 0.2,
                      defaultImageUrl: 'assets/images/pp1.png',
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2SD21CS055',
                          style: ksubHead(context).copyWith(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Nagaraj Jyoti',
                          style: ksubHead(context)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'CSE',
                          style: ksubHead(context)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              listTiles(
                title: 'Change App Theme',
                leadingIcon: Bootstrap.palette,
                switchbutton: Switch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                ),
              ),
              listTiles(
                title: 'Invite Friends',
                leadingIcon: Bootstrap.share,
              ),
              listTiles(
                title: 'Feedback',
                leadingIcon: Bootstrap.chat_square_quote,
              ),
              listTiles(
                title: 'About Us',
                leadingIcon: Bootstrap.info_circle,
              ),
              listTiles(
                title: 'Logout',
                leadingIcon: Bootstrap.box_arrow_right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class listTiles extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Switch? switchbutton;
  const listTiles({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.switchbutton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(
            title,
            style: kbody(context),
          ),
          leading: Icon(
            leadingIcon,
          ),
          trailing: switchbutton,
        ),
      ),
    );
  }
}
