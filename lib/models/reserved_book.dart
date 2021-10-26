// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class ReservedBook {
  String id;
  String student;
  DateTime issue_date;
  DateTime due_date;
  DateTime returned_date;
  String status;
  String book_cover;
  String title;
  String reserved_book;

  ReservedBook({
    required this.id,
    required this.student,
    required this.issue_date,
    required this.due_date,
    required this.returned_date,
    required this.status,
    required this.book_cover,
    required this.title,
    required this.reserved_book,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student': student,
      'issue_date': issue_date,
      'due_date': due_date,
      'returned_date': returned_date,
      'status': status,
      'book_cover': book_cover,
      'title': title,
      'reserved_book': reserved_book
    };
  }

  factory ReservedBook.fromMap(Map<String, dynamic> map) {
    return ReservedBook(
      id: map['id'].toString(),
      student: map['student'],
      issue_date: DateTime.parse(map['issue_date']),
      due_date: DateTime.parse(map['due_date']),
      returned_date: DateTime.parse(map['returned_date']),
      status: map['status'],
      book_cover: map['book_cover'],
      title: map['title'],
      reserved_book: map['reserved_book'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservedBook.fromJson(String source) =>
      ReservedBook.fromMap(json.decode(source));
}
