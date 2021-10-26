// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

class Book {
  String id;
  String title;
  String description;
  String available_quantity;
  String author;
  String book_cover;
  String department;
  String max_days_available;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.available_quantity,
    required this.author,
    required this.book_cover,
    required this.department,
    required this.max_days_available,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'available_quantity': available_quantity,
      'author': author,
      'book_cover': book_cover,
      'department': department,
      'max_days_available': max_days_available,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'].toString(),
      title: map['title'],
      description: map['description'],
      available_quantity: map['available_quantity'].toString(),
      author: map['author'],
      book_cover: map['book_cover'],
      department: map['department'],
      max_days_available: map['max_days_available'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
