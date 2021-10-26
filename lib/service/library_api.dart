import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_manager/models/book.dart';
import 'package:library_manager/models/reservebook.dart';
import 'package:library_manager/models/reserved_book.dart';

class LibraryApi {
  final String apiUrl = "https://restlibrarymanager.herokuapp.com/api/library/";
  // final String token = "4fb43b649aff9ddb42307a8512ab38554a0694f8";

  Future<List<Book>> fetchBooks(String token) async {
    final response = await http.get(
      Uri.parse(apiUrl + "books/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Book>((json) => Book.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<ReservedBook>> fetchReservedBooks(String token) async {
    final response = await http.get(
      Uri.parse(apiUrl + "user-reserved-books/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ReservedBook>((json) => ReservedBook.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load reserved Book');
    }
  }

  Future<ReserveBook> reserveBook(String bookId, String token) async {
    final response = await http.post(
        Uri.parse(apiUrl + "reserve-book/$bookId/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        });

    if (response.statusCode == 200) {
      return ReserveBook.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to reserve book.');
    }
  }

  Future<ReserveBook> returnBook(String bookId, String token) async {
    final response = await http.put(Uri.parse(apiUrl + "return-book/$bookId/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(<String, String>{'status': 'Returned'}));

    if (response.statusCode == 200) {
      return ReserveBook.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to reserve book.');
    }
  }

  // Future<ReservedBook> createTask(
  //     String title, String description, String dueDate, String status) async {
  //   final response = await http.post(
  //     Uri.parse(apiUrl + "/task/create/"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Token $token',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'title': title,
  //       'description': description,
  //       'due_date': dueDate,
  //       'status': status,
  //     }),
  //   );

  //   if (response.statusCode == 201) {
  //     return ReservedBook.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to create Task.');
  //   }
  // }

  // Future<ReservedBook> updateTask(String taskid, String title,
  //     String description, String duedate, String status) async {
  //   final response = await http.put(
  //     Uri.parse(apiUrl + "/task/$taskid/edit/"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Token $token',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'title': title,
  //       'description': description,
  //       'status': status,
  //       'due_date': duedate
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     return ReservedBook.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to update Task.');
  //   }
  // }

  fetch_reserved_books() {}
}
