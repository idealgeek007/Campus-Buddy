class Subject {
  String id;
  String subjectName;
  int ia1;
  int ia2;
  int ia3;

  Subject(
      {required this.id,
      required this.subjectName,
      required this.ia1,
      required this.ia2,
      required this.ia3});

  factory Subject.fromFirestore(Map<String, dynamic> data, String id) {
    return Subject(
      id: id,
      subjectName: data['subjectName'],
      ia1: data['IA1'],
      ia2: data['IA2'],
      ia3: data['IA3'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'subjectName': subjectName,
      'IA1': ia1,
      'IA2': ia2,
      'IA3': ia3,
    };
  }
}
