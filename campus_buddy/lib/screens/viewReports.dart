import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance Reports'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('maintenance_reports')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No reports found'));
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return ReportCard(data: data, docId: doc.id);
            }).toList(),
          );
        },
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String docId;

  ReportCard({required this.data, required this.docId});

  Future<void> _deleteReport(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('maintenance_reports')
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Report deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting report: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description: ${data['description']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('Location: ${data['location']}'),
            SizedBox(height: 5),
            data['imageUrl'] != null
                ? Image.network(data['imageUrl'])
                : SizedBox(),
            SizedBox(height: 5),
            Text('Reported by: ${data['reportedBy']['name']}'),
            Text('Email: ${data['reportedBy']['email']}'),
            Text('Semester: ${data['reportedBy']['sem']}'),
            Text('Division: ${data['reportedBy']['div']}'),
            Text('Branch: ${data['reportedBy']['branch']}'),
            SizedBox(height: 5),
            Text(
                'Timestamp: ${data['timestamp'] != null ? (data['timestamp'] as Timestamp).toDate().toString() : 'N/A'}'),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 35,
                  ),
                  onPressed: () => _deleteReport(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
