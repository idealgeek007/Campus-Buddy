import 'package:campus_buddy/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'controller.dart';
import 'model.dart';

class MarksOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Marks Tracker',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSubjectDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Consumer<SubjectProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: SizeConfig.screenWidth * 0.07,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Subject Name',
                        style: GoogleFonts.poppins(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'IA1 Marks',
                        style: GoogleFonts.poppins(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'IA2 Marks',
                        style: GoogleFonts.poppins(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataColumn(
                        label: Text(
                      'IA3 Marks',
                      style: GoogleFonts.poppins(
                          fontSize: width * 0.04, fontWeight: FontWeight.w600),
                    )),
                  ],
                  rows: provider.subjects.map((subject) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            subject.subjectName,
                            style: GoogleFonts.poppins(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        DataCell(
                          TextField(
                            style: GoogleFonts.poppins(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600),
                            controller: provider.ia1Controllers[subject.id],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        DataCell(
                          TextField(
                            style: GoogleFonts.poppins(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600),
                            controller: provider.ia2Controllers[subject.id],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),
                        DataCell(
                          TextField(
                            style: GoogleFonts.poppins(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w600),
                            controller: provider.ia3Controllers[subject.id],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20), // Add some spacing between table and button
              ElevatedButton(
                onPressed: () {
                  provider.subjects.forEach((subject) {
                    subject.ia1 = int.tryParse(
                            provider.ia1Controllers[subject.id]?.text ?? '0') ??
                        0;
                    subject.ia2 = int.tryParse(
                            provider.ia2Controllers[subject.id]?.text ?? '0') ??
                        0;
                    subject.ia3 = int.tryParse(
                            provider.ia3Controllers[subject.id]?.text ?? '0') ??
                        0;
                    provider.updateSubject(subject);
                  });
                },
                child: Text(
                  'Save All Changes',
                  style: GoogleFonts.poppins(
                      fontSize: width * 0.04, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAddSubjectDialog(BuildContext context) {
    final subjectController = TextEditingController();
    final ia1Controller = TextEditingController();
    final ia2Controller = TextEditingController();
    final ia3Controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subjectController,
                decoration: const InputDecoration(labelText: 'Subject Name'),
              ),
              TextField(
                controller: ia1Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'IA1 Marks'),
              ),
              TextField(
                controller: ia2Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'IA2 Marks'),
              ),
              TextField(
                controller: ia3Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'IA3 Marks'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                final subject = Subject(
                  id: '',
                  subjectName: subjectController.text,
                  ia1: int.parse(ia1Controller.text),
                  ia2: int.parse(ia2Controller.text),
                  ia3: int.parse(ia3Controller.text),
                );
                Provider.of<SubjectProvider>(context, listen: false)
                    .addSubject(subject);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
