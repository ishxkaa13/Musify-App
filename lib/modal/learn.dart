import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

// import 'dart:io';


var url = Uri.http('localhost:8082', '/register');


class Register {
   late String id;
   late String secretCode;
   late String name;
   late String email;
   late List<String> playlist;

  Register(
  {
  required this.id,
  required this.secretCode,
  required this.email,
  required this.name,
  required this.playlist});
   Register.fromJson(Map<String, dynamic> json) {
  // return Register(id: json["id"], secretCode: json["secretCode"], email: '', name: '', playlist: []);
   }

}

class Playlist {
   late String id;
   late String name;
   late List<String> songs;

   Playlist({required this.id,required this.name,required this.songs});
factory Playlist.fromJson(Map<String, dynamic> json) {
return Playlist(id: json["id"], name: json["playlistName"],songs : json["songs"]);
}
}

class Song {
  late String id;
  late String name;
  late String composers;
  late String url;

  Song({required this.id,required this.name,required this.composers,required this.url});
factory Song.fromJson(Map<String, dynamic> json) {
return Song(
id: json["id"],
name: json["songName"],
composers: json["composers"],
url: json["url"]);
}
}

Future<Register> createUser(String Name, String email) async {
  final response = await http.post(
    Uri.parse('http://localhost:8082/register'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{'name': Name, 'email': email}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(Register.fromJson(jsonDecode(response.body)).id);
    return Register.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<bool?> loginUser(String secretCode) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8082/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'SecretCode': secretCode}),
    );

    print(">>>");
    if (response.statusCode == 200) {
      // log(Register.fromJson(jsonDecode(response.body)).id);
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login.');
    }
  } catch (e) {
    log(e.toString());
  }
  print(">>>>>>>");
}

Future<bool?> createPlaylist(String secretCode, String name) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8082/createPlaylist'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body:
      jsonEncode(<String, String>{'secretCode': secretCode, 'name': name}),
    );
    print(">>");
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // log(Register.fromJson(jsonDecode(response.body)).id);
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Playlist.');
    }
  } catch (e) {
    log(e.toString());
  }
}

Future<bool> AddSong(String Id, String name, String secretCode) async {
  final response = await http.post(
    Uri.parse('http://localhost:8082/register'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{'playlist_id': Id, 'name': name, 'secretCode':secretCode}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return true;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to add songs.');
  }
}

