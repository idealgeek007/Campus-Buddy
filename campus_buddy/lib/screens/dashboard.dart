import 'package:flutter/material.dart';
import 'package:campus_buddy/Utils/textStylse.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Utils/SizeConfig.dart';
import '../components/appbar.dart';
import '../components/card1.dart';
import '../components/circularAvatar.dart';
import '../provider/user_provider.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    var width = SizeConfig.screenWidth;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: MyCircularAvatar(
            radius: 25,
            defaultImageUrl: 'assets/images/pp1.png',
          ),
        ),
        title: userProvider.user == null
            ? Center(child: CircularProgressIndicator())
            : Text(
                'Hi ${userProvider.user!.name}',
                style: GoogleFonts.poppins(
                  fontSize: SizeConfig.screenWidth / 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
      body: userProvider.user == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Notice',
                    style: kheading(context),
                  ),
                  Card(
                    elevation: 4,
                    child: SizedBox(
                      height: 200,
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Explore',
                    style: kheading(context),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        card1(
                          'Clubs',
                          'assets/images/cardimages/clubs.png',
                          width / 2,
                          Theme.of(context).brightness == Brightness.dark
                              ? Color(0xff8cbfae)
                              : Color(0xffC3E2C2),
                          context,
                        ),
                        card1(
                          'Bus Tracking',
                          'assets/images/cardimages/bus.png',
                          width / 2,
                          Theme.of(context).brightness == Brightness.dark
                              ? Color(0xff7881b9)
                              : Color(0xffDBD2FF),
                          context,
                        ),
                        card1(
                          'Opportunities',
                          'assets/images/cardimages/Opportunities.png',
                          width / 2,
                          Theme.of(context).brightness == Brightness.dark
                              ? Color(0xffaa898f)
                              : Color(0xffE2C2C8),
                          context,
                        ),
                        card1(
                          'Maintenance Reporting',
                          'assets/images/cardimages/maintenance.png',
                          width / 2,
                          Theme.of(context).brightness == Brightness.dark
                              ? Color(0xff8cbfae)
                              : Color(0xffC2DAE2),
                          context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
