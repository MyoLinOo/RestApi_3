import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3/service/note_service.dart';
import 'package:get_it/get_it.dart';

class NoteDelete extends StatelessWidget {
  final id;

  const NoteDelete({this.id});
  NoteService get noteService => GetIt.I<NoteService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AlertDialog(
          title: Text("Warning"),
          content: Text("Are you sure you want to delete this note?"),
          actions: [
            FlatButton(
                onPressed: () {
                  noteService.deleteNoteList(id);
                  Navigator.of(context).pop(context);
                },
                child: Text("Yes")),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
                child: Text("No"))
          ],
        ),
      ),
    );
  }
}
