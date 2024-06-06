import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageCRPage extends StatefulWidget {
  @override
  _ManageCRPageState createState() => _ManageCRPageState();
}

class _ManageCRPageState extends State<ManageCRPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage CRs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter Email of New CR',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _emailController.clear();
                  },
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              addCR(_emailController.text.trim());
            },
            child: Text('Add CR'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('isCR', isEqualTo: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No CRs found.'));
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                      subtitle: Text(data['email']),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Toggle isCR value
                          toggleCRStatus(doc.id, data['isCR']);
                        },
                        child: Text(data['isCR'] ? 'Remove CR' : 'Add CR'),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void addCR(String email) async {
    try {
      // Check if user with provided email exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // User with provided email not found
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User with email $email not found.'),
        ));
        return;
      }

      // Update isCR status to true for the user with provided email
      String userId = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'isCR': true});

      // Clear the email text field
      _emailController.clear();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User with email $email added as CR.'),
      ));
    } catch (e) {
      print('Error adding CR: $e');
      // Handle error
    }
  }

  void toggleCRStatus(String userId, bool currentIsCRStatus) async {
    try {
      // Update isCR status in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'isCR': !currentIsCRStatus});
    } catch (e) {
      print('Error toggling CR status: $e');
      // Handle error
    }
  }
}
