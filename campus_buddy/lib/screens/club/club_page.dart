import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart' as mongo;

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
    fetchData();
  }

  Future<void> fetchData() async {
    final mongo.Db db = mongo.Db(
        'mongodb+srv://nagarajkj7:p15BbYxTRgqxYKvl@cluster0.x3ol6py.mongodb.net/Campus_Buddy');

    final mongo.DbCollection collection = db.collection('clubs');

    await db.open();

    final List<Map<String, dynamic>> clubData =
        await collection.find().toList();

    setState(() {
      clubs = clubData
          .map((data) => Club(
                name: data['name'],
                details: data['details'],
                leader: data['leader'],
                contactDetails: data['contactDetails'],
                socialMediaHandles: data['socialMediaHandles'],
                photoUrl: data['photoUrl'],
              ))
          .toList();
    });
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
