import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

var url = Uri.http('localhost:8080', '/register');

class User {
   String id;
   String secretCode;
   String name;
   String email;
   List playlist;

  User(
      {required this.id,
      required this.secretCode,
      required this.email,
      required this.name,
      required this.playlist});
  factory User.fromJson(Map<String, dynamic> json) {


    return User(
        id: json["userid"],
        secretCode: json["secretcode"],
        email: json["email"],
        name: json["name"],
        playlist: json["plist"]);
  }
}

Future<User> createUser(String name, String email) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/register'),
    body: jsonEncode(<String, String>{'name': name, 'email': email}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // print(Register.fromJson(jsonDecode(response.body)));
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<bool?> loginUser(String secretcode) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/login'),
      body: jsonEncode(<String, String>{'secretcode': secretcode}),
    );

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
  return null;
}

Future<User> viewProfile(String secretcode) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/viewprofile'),
    body: jsonEncode(<String, String>{'secretcode': secretcode}),
  );
  try {
    if (response.statusCode == 200) {
      // log(Register.fromJson(jsonDecode(response.body)).id);
      // try {
      //   print("resbody");
      //   print(response.body);
      //   var data = jsonDecode(response.body);
      //   print("resdecoded data");
      //   print(data);
      //   data["plist"] = [];
      //   print(User.fromJson(data));
      //
      // } catch(e){
      //   print("hitakshi");
      //   print(e);
      // }
      var User1 = User.fromJson(jsonDecode(response.body));
      return User1;

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login.');
    }
  } catch (e) {
    log( ">>> ${e.toString()}");
    rethrow;
  }
}

Future<User?> createPlaylist(String secretCode, String pname) async {
  try {
    final response = await http.post(
      Uri.parse('http://localhost:8080/createplaylist'),

      body:
      jsonEncode(<String, String>{'secretcode': secretCode, 'name': pname}),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // log(Register.fromJson(jsonDecode(response.body)).id);
      var User1 = User.fromJson(jsonDecode(response.body));
      return User1;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Playlist.');
    }
  } catch (e) {
    log(e.toString());
  }
}