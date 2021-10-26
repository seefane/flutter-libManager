// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:library_manager/models/book.dart';
import 'package:library_manager/service/auth_provider.dart';
import 'package:library_manager/service/library_provider.dart';

class BookDetailsScreen extends StatefulWidget {
  Book book;
  BookDetailsScreen({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState(book);
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  _BookDetailsScreenState(this.book);

  Book book;
  BookProvider? booknotifier;
  late String availableQty;
  late String description;
  late String author;
  late String department;
  late String maxAvailableDays;

  @override
  void didChangeDependencies() {
    final booknotifier = Provider.of<BookProvider>(context);
    final authProvider = Provider.of<UserAuthProvider>(context);
    if (this.booknotifier != booknotifier) {
      this.booknotifier = booknotifier;
      String token = authProvider.token;
      booknotifier.fetch_reserved_books(token);
      availableQty = book.available_quantity;
      description = book.description;
      author = book.author;
      maxAvailableDays = book.max_days_available;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<UserAuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        backgroundColor: const Color(0xfff4f4f4),
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                book.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            Center(
              child: Card(
                elevation: 5,
                child: Hero(
                  tag: book.id,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(
                      book.book_cover,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        return const Center(child: LinearProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('Some errors occurred!'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Available Quantity: " + availableQty,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "This book can only be borrowed a max of " +
                              maxAvailableDays +
                              " days",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Author: $author",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          const SizedBox(
            width: 22,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: booknotifier!.getCheckBookReservation(book.title)
                  ? null
                  : () async {
                      await booknotifier!
                          .reserveBook(book.id, authProvider.token);
                      _showMaterialDialog("Book Reservation",
                          "You have successfully reserved the book");
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  Icon(
                    Icons.add,
                  ),
                  Text(
                    'Borrow',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: !booknotifier!.getCheckBookReservation(book.title)
                  ? null
                  : () async {
                      await booknotifier!
                          .returnBook(book.id, authProvider.token);
                      _showMaterialDialog("Book Return",
                          "You have successfully returned the book");
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.redo,
                  ),
                  SizedBox(
                    height: 5,
                    width: 5,
                  ),
                  Text(
                    'Return Book',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 22,
          ),
        ],
      ),
    );
  }

  void _showMaterialDialog(String title, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        }).then((value) async {
      final authProvider = Provider.of<UserAuthProvider>(context);
      await booknotifier!.fetch_reserved_books(authProvider.token);
      await booknotifier!.fetch_library_books(authProvider.token);
    });
  }
}
