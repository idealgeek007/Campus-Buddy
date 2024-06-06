import 'package:flutter/material.dart';

class Club {
  final String name;
  final String details;
  final String leader;
  final String contactDetails;
  final String socialMediaHandles;
  final String photoUrl;

  Club({
    required this.name,
    required this.details,
    required this.leader,
    required this.contactDetails,
    required this.socialMediaHandles,
    required this.photoUrl,
  });
}

class ClubPage extends StatefulWidget {
  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  List<Club> clubs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clubs'),
      ),
      body: ListView.builder(
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(clubs[index].photoUrl),
            title: Text(clubs[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(clubs[index].details),
                Text('Leader: ${clubs[index].leader}'),
                Text('Contact Details: ${clubs[index].contactDetails}'),
                Text(
                    'Social Media Handles: ${clubs[index].socialMediaHandles}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
