import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_manager/models/book.dart';
import 'package:library_manager/models/reserved_book.dart';
import 'package:library_manager/models/user.dart';

class UserAuthApi {
  final String api_url = "https://restlibrarymanager.herokuapp.com/api/";

  Future<User> signIn(String username, String password) async {
    final response = await http.post(
      Uri.parse(api_url + "user/login/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<User> updateUser(String token, String taskid, String title,
      String description, String duedate, String status) async {
    final response = await http.put(
      Uri.parse(api_url + "/task/$taskid/edit/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'description': description,
        'status': status,
        'due_date': duedate
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user details.');
    }
  }
}
