import 'package:flutter/material.dart';
import 'package:library_manager/service/auth_provider.dart';
import 'package:library_manager/widgets/horizontal_book_widget.dart';
import 'package:provider/provider.dart';

import 'package:library_manager/service/library_provider.dart';

class HorizontalScreen extends StatefulWidget {
  HorizontalScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HorizontalScreenState createState() => _HorizontalScreenState();
}

class _HorizontalScreenState extends State<HorizontalScreen> {
  BookProvider? booknotifier;

  @override
  void didChangeDependencies() {
    final booknotifier = Provider.of<BookProvider>(context);
    final authProvider = Provider.of<UserAuthProvider>(context);
    if (this.booknotifier != booknotifier) {
      this.booknotifier = booknotifier;
      String token = authProvider.token;
      booknotifier.fetch_reserved_books(token);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var reservedbooks = context.watch<BookProvider>();

    return reservedbooks.reserved_books.isEmpty
        ? const Center(child: Text("You do not have any reserved books"))
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: reservedbooks.get_reserved_books.length,
            itemBuilder: (context, index) {
              return HorizontalCard(
                  title: reservedbooks.get_reserved_books[index].title,
                  imageUrl: reservedbooks.get_reserved_books[index].book_cover,
                  id: reservedbooks.get_reserved_books[index].id);
            });
  }
}
