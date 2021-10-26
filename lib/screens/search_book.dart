import 'package:flutter/material.dart';
import 'package:library_manager/models/book.dart';

class BookSearch extends SearchDelegate<Book> {
  final List<Book> books;
  late Book book;

  BookSearch(this.books);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = books.where((book) {
      return book.title.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            suggestions.elementAt(index).title,
          ),
          onTap: () {
            book = suggestions.elementAt(index);
            close(context, book);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = books.where((book) {
      return book.title.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            suggestions.elementAt(index).title,
          ),
          onTap: () {
            query = suggestions.elementAt(index).title;
            book = suggestions.elementAt(index);
            close(context, book);
          },
        );
      },
    );
  }
}
