import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3/model/note.dart';
import 'package:flutter_rest_api_3/model/note_for_listening.dart';
import 'package:flutter_rest_api_3/service/api_response.dart';
import 'package:flutter_rest_api_3/service/note_service.dart';
import 'package:flutter_rest_api_3/view/note_create.dart';
import 'package:flutter_rest_api_3/view/note_delete.dart';
import 'package:flutter_rest_api_3/view/note_modify.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NoteService get service => GetIt.instance<NoteService>();
  NoteService noteService;
  List<NoteForListening> notes = [];

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  APIResponse<List<NoteForListening>> _apiResponse;
  bool _isloading = false;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isloading = true;
    });

    _apiResponse = await service.getNoteList();

    setState(() {
      _isloading = false;
    });
  }

  // Future<List<Note>> getNews() async {
  //   var url = await http.get("https://5fb3df8fb6601200168f801d.mockapi.io/api");

  //   var jsonData = jsonDecode(url.body);
  //   print(jsonData);
  //   List<Note> notesList = [];
  //   for (var data in jsonData) {
  //     Note newsdata = Note(
  //         id: data['id'],
  //         name: data['name'],
  //         age: data['age'],
  //         job: data['job']);

  //     notesList.add(newsdata);
  //   }
  //   return notesList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoteCreate()))
              .then((value) {
            _fetchNotes();
          });
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: service.getNoteList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.red),
            );
          } else {
            return ListView.builder(
              itemCount: _apiResponse.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    color: Colors.blue,
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actions: [
                        IconSlideAction(
                          icon: Icons.edit,
                          color: Colors.green,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoteModify(
                                          id: _apiResponse.data[index].id,
                                          name: _apiResponse.data[index].name,
                                          age: _apiResponse.data[index].age,
                                          job: _apiResponse.data[index].job,
                                        ))).then((value) {
                              _fetchNotes();
                            });
                          },
                        ),
                      ],
                      secondaryActions: [
                        IconSlideAction(
                          icon: Icons.delete,
                          color: Colors.red,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NoteDelete(
                                  id: _apiResponse.data[index].id);
                            })).then((value) {
                              _fetchNotes();
                            });
                          },
                        ),
                      ],
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_apiResponse.data[index].name, maxLines: 1),
                          Expanded(child: SizedBox(height: 1)),
                          Text(_apiResponse.data[index].age.toString()),
                          Expanded(child: SizedBox(height: 1)),
                          Text(_apiResponse.data[index].job, maxLines: 1),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
