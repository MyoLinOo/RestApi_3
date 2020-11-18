import 'package:flutter/cupertino.dart';
import 'package:flutter_rest_api_3/model/note.dart';

class NoteInsert {
  String name;
  String job;
  String age;

  NoteInsert({@required this.name, @required this.job, @required this.age});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'job': job,
      'age': age,
    };
  }
}
