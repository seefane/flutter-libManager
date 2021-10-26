import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/models/book.dart';
import 'package:library_manager/screens/book_details.dart';
import 'package:library_manager/screens/horizontal_view.dart';
import 'package:library_manager/screens/search_book.dart';
import 'package:library_manager/screens/vertial_view.dart';
import 'package:library_manager/service/auth_provider.dart';
import 'package:library_manager/service/library_provider.dart';
import 'package:library_manager/widgets/book_widget.dart';
import 'package:library_manager/widgets/horizontal_book_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var libraryProvider = Provider.of<BookProvider>(context, listen: false);
    var auth = Provider.of<UserAuthProvider>(context, listen: false);
    String token = auth.token;
    int? _department = libraryProvider.getDepartment;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library Manager"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final book = await showSearch<Book>(
                context: context,
                delegate: BookSearch(libraryProvider.get_library_books),
              );
              if (book != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookDetailsScreen(book: book))).then((value) async {
                  await libraryProvider
                      .fetch_library_books(auth.token)
                      .then((value) async {
                    await libraryProvider.fetch_reserved_books(auth.token);
                  });
                });
              }
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: pullRefresh,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Activte Book Reservations',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      child: const Text('View All'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 280,
                child: HorizontalScreen(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Available Books',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton(
                      value: _department,

                      // ignore: prefer_const_literals_to_create_immutables
                      items: [
                        const DropdownMenuItem(
                          child: Text("All Books"),
                          value: 0,
                        ),
                        const DropdownMenuItem(
                          child: Text("Education"),
                          value: 1,
                        ),
                        const DropdownMenuItem(
                          child: Text("Computer Science"),
                          value: 2,
                        ),
                        const DropdownMenuItem(
                          child: Text("Mathematics"),
                          value: 3,
                        ),
                        const DropdownMenuItem(
                          child: Text("Engineering"),
                          value: 4,
                        )
                      ],
                      onChanged: (status) {
                        setState(() {
                          _department = status as int;
                        });
                        libraryProvider.setDepartment(_department!);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                  height: 500,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const AvailiableBooks()),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pullRefresh() async {
    var auth = await Provider.of<UserAuthProvider>(context, listen: false);

    await Provider.of<BookProvider>(context, listen: false)
        .fetch_library_books(auth.token);
  }
}
