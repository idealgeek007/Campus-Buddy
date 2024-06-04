import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/textStylse.dart';
import '../components/appbar.dart';
import '../components/circularAvatar.dart';
import '../screens/Login_Register/loginnew.dart';
import '../authentication/authService.dart';
import '../provider/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;
    final userProvider = Provider.of<UserProvider>(context);

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
                        if (userProvider.user != null) ...[
                          Text(
                            userProvider
                                .user!.name, // Assuming 'USN' is stored in 'id'
                            style: ksubHead(context).copyWith(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            userProvider.user!.email,
                            style: ksubHead(context)
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'SEM', // Replace with actual semester data if available
                            style: ksubHead(context)
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ] else ...[
                          CircularProgressIndicator(),
                        ]
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
                onTap: () {},
              ),
              listTiles(
                title: 'Invite Friends',
                leadingIcon: Bootstrap.share,
                onTap: () {},
              ),
              listTiles(
                title: 'Feedback',
                leadingIcon: Bootstrap.chat_square_quote,
                onTap: () {},
              ),
              listTiles(
                title: 'About Us',
                leadingIcon: Bootstrap.info_circle,
                onTap: () {},
              ),
              listTiles(
                title: 'Logout',
                leadingIcon: Bootstrap.box_arrow_right,
                onTap: () => logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}

class listTiles extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Switch? switchbutton;
  final VoidCallback onTap;
  const listTiles({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.switchbutton,
    required this.onTap,
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
          onTap: onTap,
        ),
      ),
    );
  }
}
