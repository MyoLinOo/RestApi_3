import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3/model/note.dart';
import 'package:flutter_rest_api_3/model/note_for_listening.dart';
import 'package:flutter_rest_api_3/model/note_insert.dart';
import 'package:flutter_rest_api_3/service/api_response.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const API_URL = "https://5fb3df8fb6601200168f801d.mockapi.io";

  Future<APIResponse<List<NoteForListening>>> getNoteList() async {
    var url = await http.get(API_URL + "/api");
    print('Url . body....' + url.body);
    if (url.statusCode == 200) {
      final jsonData = jsonDecode(url.body);
      List<NoteForListening> notes = [];
      for (var data in jsonData) {
        notes.add(NoteForListening.fromJson(data));
      }

      return APIResponse<List<NoteForListening>>(data: notes);
    } else {
      return APIResponse<List<NoteForListening>>(
        error: true,
        errorMessage: 'An error occured',
      );
    }
  }

  Future<APIResponse<Note>> getNotes(String id) async {
    return await http.get(API_URL + "/api/$id").then((value) {
      if (value.statusCode == 200) {
        final jsonData = json.decode(value.body);
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      } else {
        return APIResponse<Note>(
          error: true,
          errorMessage: 'An error occured',
        );
      }
    });
  }

// Future<http.Response> createAlbum(String title) {
//   return http.post(
//     API_URL+"/api",
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
// }

  // Future<APIResponse<NoteInsert>> createNoteList(NoteInsert noteInsert) async {
  //   var url = await http.post(API_URL + "/api", body: json.encode(noteInsert));
  //   final jsonData = jsonDecode(url.body);

  //   if (url.statusCode == 200) {
  //     return APIResponse<NoteInsert>(data: jsonData);
  //   } else {
  //     return APIResponse<NoteInsert>(
  //       error: true,
  //       errorMessage: 'An error occured',
  //     );
  //   }
  // }
  static const header = {'Content-Type': "application/json"};

  Future<APIResponse<bool>> createNoteList(NoteInsert item) async {
    return await http
        .post(API_URL + "/api/",
            headers: header, body: json.encode(item.toJson()))
        .then((value) {
      if (value.statusCode == 201) {
        return APIResponse<bool>(data: true);
      } else {
        return APIResponse(error: true, errorMessage: "AnError occoured");
      }
    });
  }

  Future<APIResponse<bool>> updateNoteList(String id, NoteInsert item) async {
    return await http
        .put(API_URL + "/api/" + id,
            headers: header, body: json.encode(item.toJson()))
        .then((value) {
      if (value.statusCode == 201) {
        return APIResponse<bool>(data: true);
      } else {
        return APIResponse(error: true, errorMessage: "AnError occoured");
      }
    });
  }

  Future<APIResponse<bool>> deleteNoteList(String id) async {
    return await http
        .delete(API_URL + "/api/" + id, headers: header)
        .then((value) {
      if (value.statusCode == 204) {
        return APIResponse<bool>(data: true);
      } else {
        return APIResponse(error: true, errorMessage: "AnError occoured");
      }
    });
  }
}
