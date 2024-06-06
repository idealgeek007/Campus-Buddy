import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostNoticePage extends StatefulWidget {
  @override
  _PostNoticePageState createState() => _PostNoticePageState();
}

class _PostNoticePageState extends State<PostNoticePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void postNotice() async {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('Notices').add({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });
      Navigator.of(context).pop();
    } else {
      print("Title and description cannot be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Notice"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Enter notice title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Enter notice description',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: postNotice,
              child: Text('Post Notice'),
            ),
          ],
        ),
      ),
    );
  }
}
