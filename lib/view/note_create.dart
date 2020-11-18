import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3/model/note_insert.dart';
import 'package:flutter_rest_api_3/service/note_service.dart';
import 'package:get_it/get_it.dart';

class NoteCreate extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  NoteService get noteService => GetIt.I<NoteService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create note"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "name"),
            ),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(hintText: "job"),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(hintText: "age"),
            ),
            RaisedButton(
              onPressed: () async {
                NoteInsert noteInsert = NoteInsert(
                  name: _nameController.text,
                  job: _jobController.text,
                  age: _ageController.text,
                );

                await noteService.createNoteList(noteInsert);
                Navigator.pop(context);
              },
              child: Text("Summit"),
            )
          ],
        ),
      ),
    );
  }
}
