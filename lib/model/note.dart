class Note {
  String id;
  String name;
  String job;
  String age;

  Note({this.id, this.name, this.job, this.age});

  factory Note.fromJson(Map<String, dynamic> data) {
    return Note(
      id: data['id'],
      name: data['name'],
      job: data['job'],
      age: data['age'],
    );
  }
}
