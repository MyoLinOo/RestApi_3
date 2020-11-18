// import 'package:json_annotation/json_annotation.dart';

// part "note_for_listening.g.dart";

class NoteForListening {
  String id;
  String name;
  String job;
  String age;

  NoteForListening({
    this.id,
    this.name,
    this.job,
    this.age,
  });

  factory NoteForListening.fromJson(Map<String, dynamic> data) {
    return NoteForListening(
      id: data['id'],
      name: data['name'],
      job: data['job'],
      age: data['age'],
    );
  }
}
