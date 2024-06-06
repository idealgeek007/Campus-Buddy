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
                    DataColumn(
                        label: Text(
                      'Delete',
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
                        DataCell(IconButton(
                          onPressed: () => provider.deleteSubject(subject.id),
                          icon: Icon(Icons.delete),
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20), // Add some spacing between table and button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Color(0xff8cbfae)
                          : Color(0xffC3E2C2),
                ),
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
                decoration: InputDecoration(
                  labelText: 'Subject Name',
                  labelStyle: GoogleFonts.poppins(
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.w500),
                ),
              ),
              TextField(
                controller: ia1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'IA1 Marks',
                  labelStyle: GoogleFonts.poppins(
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.w400),
                ),
              ),
              TextField(
                controller: ia2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'IA2 Marks',
                  labelStyle: GoogleFonts.poppins(
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.w400),
                ),
              ),
              TextField(
                controller: ia3Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'IA3 Marks',
                  labelStyle: GoogleFonts.poppins(
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                    fontSize: SizeConfig.screenWidth * 0.04,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                'Add',
                style: GoogleFonts.poppins(
                    fontSize: SizeConfig.screenWidth * 0.04,
                    fontWeight: FontWeight.w600),
              ),
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
