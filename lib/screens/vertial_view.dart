import 'package:flutter/material.dart';
import 'package:library_manager/models/book.dart';
import 'package:library_manager/screens/book_details.dart';
import 'package:library_manager/service/auth_provider.dart';
import 'package:library_manager/service/library_provider.dart';
import 'package:library_manager/widgets/book_widget.dart';
import 'package:provider/provider.dart';

class AvailiableBooks extends StatefulWidget {
  const AvailiableBooks({Key? key}) : super(key: key);

  @override
  _AvailiableBooksState createState() => _AvailiableBooksState();
}

class _AvailiableBooksState extends State<AvailiableBooks> {
  BookProvider? booknotifier;

  @override
  void didChangeDependencies() {
    final booknotifier = Provider.of<BookProvider>(context);
    final authProvider = Provider.of<UserAuthProvider>(context);
    if (this.booknotifier != booknotifier) {
      this.booknotifier = booknotifier;
      String token = authProvider.token;
      booknotifier.fetch_library_books(token);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var _librarybooks = Provider.of<BookProvider>(context);
    var auth = Provider.of<UserAuthProvider>(context, listen: false);

    var _books = getFilteredBooks(
        booknotifier!.get_library_books, booknotifier!.getDepartment);

    return _books.isEmpty
        ? const Center(
            child: Text("This department has no books available"),
          )
        : ListView.builder(
            itemCount: _books.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onDoubleTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailsScreen(book: _books[index])))
                      .then((value) async {
                    await booknotifier!
                        .fetch_library_books(auth.token)
                        .then((value) async {
                      await booknotifier!.fetch_reserved_books(auth.token);
                    });
                  });
                },
                child: BookCard(
                    title: _books[index].title,
                    description: _books[index].description,
                    book_cover: _books[index].book_cover),
              );
            });
  }

  List<Book> getFilteredBooks(List<Book> books, int department) {
    switch (department) {
      case 1:
        {
          return books.where((book) => book.department == "Education").toList();
        }
      case 2:
        {
          return books
              .where((book) => book.department == "Computer Science")
              .toList();
        }
      case 3:
        {
          return books
              .where((book) => book.department == "Mathematics")
              .toList();
        }
      case 4:
        {
          return books
              .where((book) => book.department == "Engineering")
              .toList();
        }
    }
    return books;
  }
}
