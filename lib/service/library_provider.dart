// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:library_manager/models/book.dart';
import 'package:library_manager/models/reservebook.dart';
import 'package:library_manager/models/reserved_book.dart';
import 'package:library_manager/service/library_api.dart';

class BookProvider extends ChangeNotifier {
  List<Book> library_books = [];
  List<ReservedBook> reserved_books = [];
  int department = 0;
  bool IsSearching = false;
  get getDepartment => department;

  get get_reserved_books => reserved_books;

  void setDepartment(int depart) {
    department = depart;
    notifyListeners();
  }

  Future<List<ReservedBook>> fetch_reserved_books(String token) async {
    reserved_books = await LibraryApi().fetchReservedBooks(token);
    notifyListeners();
    return reserved_books;
  }

  Book getReservedBookFromLibrary(String title) {
    late Book book;
    for (var bok in library_books) {
      if (bok.title == title) {
        book = bok;
      }
    }
    return book;
  }

  bool getCheckBookReservation(String title) {
    bool isReserved = false;
    for (var bok in reserved_books) {
      if (bok.title == title) {
        isReserved = true;
        break;
      }
    }
    return isReserved;
  }

  get get_library_books {
    return library_books;
  }

  Future<List<Book>> fetch_library_books(String token) async {
    library_books = await LibraryApi().fetchBooks(token);
    notifyListeners();
    return library_books;
  }

  Future<ReserveBook> reserveBook(String bookid, String token) async {
    var reservedBook = await LibraryApi().reserveBook(bookid, token);
    notifyListeners;
    return reservedBook;
  }

  Future<ReserveBook> returnBook(String bookid, String token) async {
    var bookReturn = await LibraryApi().returnBook(bookid, token);
    notifyListeners;
    return bookReturn;
  }
}
