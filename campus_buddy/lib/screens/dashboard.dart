import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../Utils/SizeConfig.dart';
import '../Utils/textStylse.dart';
import '../components/appbar.dart';
import '../components/card1.dart';
import '../components/circularAvatar.dart';
import '../provider/user_provider.dart';
import 'MaintenanceReporting/maintenance.dart';
import 'Resources/resourcesWebview.dart';
import 'TimeTable/timetable.dart';
import 'MarkaTracker/view.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserData().then((_) {
      if (userProvider.user != null && userProvider.user!.isAdmin) {
        setState(() {
          isAdmin = true;
        });
      }
    });
  }

  Future<void> _deleteNotice(String noticeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Notices')
          .doc(noticeId)
          .delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Notice deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting notice: $e')));
    }
  }

  void _showNoticeDialog(BuildContext context, String title, String description,
      DateTime timestamp, String noticeId) {
    String formattedDate = DateFormat('dd-MM-yy hh:mm').format(timestamp);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var width = SizeConfig.screenWidth;
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: width * 0.05, fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  description,
                  style: GoogleFonts.poppins(
                      fontSize: width * 0.045, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  'Published on: $formattedDate',
                  style: GoogleFonts.poppins(
                      fontSize: width * 0.03, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (isAdmin)
              TextButton(
                child: Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteNotice(noticeId);
                },
              ),
          ],
        );
      },
    );
  }

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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: Container(
                      height: 200,
                      color: Theme.of(context).colorScheme.secondary,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Notices')
                            .orderBy('timestamp', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          var notices = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: notices.length,
                            itemBuilder: (context, index) {
                              var notice = notices[index];
                              String noticeId = notice.id;
                              String title = notice['title'];
                              String description = notice['description'];
                              String truncatedDescription =
                                  description.length > 50
                                      ? description.substring(0, 50) + '...'
                                      : description;
                              DateTime timestamp =
                                  (notice['timestamp'] as Timestamp).toDate();
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  child: ListTile(
                                    title: Text(
                                      '${index + 1} - ' + title,
                                      style: GoogleFonts.poppins(
                                          fontSize: width * 0.05,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      truncatedDescription,
                                      style: GoogleFonts.poppins(
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    onTap: () => _showNoticeDialog(
                                        context,
                                        title,
                                        description,
                                        timestamp,
                                        noticeId),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
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
                        GestureDetector(
                          child: card1(
                            'Timetable',
                            'assets/images/c3Images/timetable.png',
                            width / 2,
                            Theme.of(context).brightness == Brightness.dark
                                ? Color(0xff8cbfae)
                                : Color(0xffC3E2C2),
                            context,
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TimeTables(),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: card1(
                            'Marks Tracker',
                            'assets/images/c3Images/IA.png',
                            width / 2,
                            Theme.of(context).brightness == Brightness.dark
                                ? Color(0xff7881b9)
                                : Color(0xffDBD2FF),
                            context,
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarksOverview(),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _openWebView(context,
                                'https://sdmcselibrary.blogspot.com/p/home.html'); // Replace with your desired URL
                          },
                          child: card1(
                            'Resources',
                            'assets/images/c3Images/resources.png',
                            width / 2,
                            Theme.of(context).brightness == Brightness.dark
                                ? Color(0xffaa898f)
                                : Color(0xffE2C2C8),
                            context,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MaintenanceReportingPage(),
                            ),
                          ),
                          child: card1(
                            'Maintenance Reporting',
                            'assets/images/cardimages/maintenance.png',
                            width / 2,
                            Theme.of(context).brightness == Brightness.dark
                                ? Color(0xff8cbfae)
                                : Color(0xffC2DAE2),
                            context,
                          ),
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
