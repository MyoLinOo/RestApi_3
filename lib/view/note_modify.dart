import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3/model/note.dart';
import 'package:flutter_rest_api_3/model/note_insert.dart';
import 'package:flutter_rest_api_3/service/note_service.dart';
import 'package:get_it/get_it.dart';

class NoteModify extends StatefulWidget {
  final String id;
  final String name;
  final String job;
  final String age;
  const NoteModify({this.name, this.job, this.age, this.id});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.id != null;
  NoteService get noteService => GetIt.I<NoteService>();
  String errorMessage;
  Note note;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    print("widge.id is......." + widget.id);
    noteService.getNotes(widget.id).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value.error) {
        errorMessage = value.errorMessage ?? "An error occured";
      } else {
        note = value.data;
      }

      if (isEditing) {
        _nameController.text = note.name;
        _jobController.text = note.job;
        _ageController.text = note.age;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEditing ? Text("Edit note") : Text("Create note"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                      if (isEditing) {
                        NoteInsert noteInsert = NoteInsert(
                          name: _nameController.text,
                          job: _jobController.text,
                          age: _ageController.text,
                        );

                        await noteService.updateNoteList(widget.id, noteInsert);
                        Navigator.pop(context);
                      } else {
                        NoteInsert noteInsert = NoteInsert(
                          name: _nameController.text,
                          job: _jobController.text,
                          age: _ageController.text,
                        );

                        await noteService.createNoteList(noteInsert);
                        Navigator.pop(context);
                      }
                    },
                    child: isEditing ? Text("Update") : Text("Summit"),
                  )
                ],
              ),
            ),
    );
  }
}
