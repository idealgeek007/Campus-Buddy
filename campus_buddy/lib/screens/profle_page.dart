import 'package:campus_buddy/screens/Admin/manageCR.dart';
import 'package:campus_buddy/screens/sendNotice.dart';
import 'package:campus_buddy/screens/viewReports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../theme/theme.dart';

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
    void saveChanges() async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user != null) {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userProvider.user!.id) // Assuming 'id' is the document ID
              .update({
            'name': userProvider.user!.name,
            'sem': userProvider.user!.sem,
            'division': userProvider.user!.div,
            'branch': userProvider.user!.branch,
          });
          // Optionally, show a success message
        } catch (e) {
          print('Error saving changes: $e');
          // Handle error appropriately
        }
      }
    }

    void editProfile(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Profile'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: userProvider.user!.name,
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    setState(() {
                      userProvider.user!.name = value;
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  value: userProvider.user!.branch,
                  decoration: InputDecoration(labelText: 'Branch'),
                  onChanged: (value) {
                    setState(() {
                      userProvider.user!.branch = value!;
                    });
                  },
                  items: [
                    'AI & ML',
                    'Civil',
                    'Chemical',
                    'Computer Science',
                    'Electrical',
                    'Electronics & Communication',
                    'Mechanical',
                  ].map<DropdownMenuItem<String>>((String branch) {
                    return DropdownMenuItem<String>(
                      value: branch,
                      child: Text(branch),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField<String>(
                  value: userProvider.user!.div,
                  decoration: InputDecoration(labelText: 'Division'),
                  onChanged: (value) {
                    setState(() {
                      userProvider.user!.div = value!;
                    });
                  },
                  items: ['A', 'B']
                      .map<DropdownMenuItem<String>>((String division) {
                    return DropdownMenuItem<String>(
                      value: division,
                      child: Text(division),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField<String>(
                  value: userProvider.user!.sem.toString(),
                  decoration: InputDecoration(labelText: 'Semester'),
                  onChanged: (value) {
                    setState(() {
                      userProvider.user!.sem = int.parse(value!);
                    });
                  },
                  items: List.generate(
                    8,
                    (index) => DropdownMenuItem<String>(
                      value: (index + 1).toString(),
                      child: Text('Semester ${index + 1}'),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  saveChanges();
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: MyAppBar(title: 'Profile', actions: []),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (userProvider.user != null) ...[
                      Text(
                        "Name: " + userProvider.user!.name,
                        style: ksubHead(context).copyWith(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        userProvider.user!.email,
                        style: ksubHead(context)
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        userProvider.user!.branch,
                        style: ksubHead(context)
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            userProvider.user!.sem.toString(),
                            style: ksubHead(context)
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            userProvider.user!.div,
                            style: ksubHead(context)
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ] else ...[
                      CircularProgressIndicator(),
                    ]
                  ],
                ),
              ),
              listTiles(
                title: 'Edit Profile',
                leadingIcon: Bootstrap.person_vcard,
                onTap: () => editProfile(context),
              ),
              listTiles(
                title: 'Change App Theme',
                leadingIcon: Bootstrap.palette,
                switchbutton: Switch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                      // Toggle theme when switch is changed
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    });
                  },
                ),
                onTap: () {},
              ),
              if (userProvider.user != null && userProvider.user!.isAdmin)
                listTiles(
                  title: 'Manage CRs',
                  leadingIcon: Bootstrap.info_circle,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ManageCRPage())),
                ),
              if (userProvider.user != null && userProvider.user!.isAdmin)
                listTiles(
                  title: 'Send Notice',
                  leadingIcon: Bootstrap.chat_square_quote,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostNoticePage(),
                      )),
                ),
              if (userProvider.user != null && userProvider.user!.isAdmin)
                listTiles(
                  title: 'Maintenance Reports',
                  leadingIcon: Bootstrap.flag,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewReportsPage(),
                      )),
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
