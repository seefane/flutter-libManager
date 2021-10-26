import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/models/book.dart';
import 'package:library_manager/screens/book_details.dart';
import 'package:library_manager/service/auth_provider.dart';
import 'package:library_manager/service/library_provider.dart';
import 'package:provider/provider.dart';

class HorizontalCard extends StatelessWidget {
  String title;
  String imageUrl;
  String id;

  HorizontalCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserAuthProvider>(context, listen: false);
    final libprovider = Provider.of<BookProvider>(context);

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: 160,
      child: GestureDetector(
        onTap: () {
          var book = libprovider.getReservedBookFromLibrary(title);

          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDetailsScreen(book: book)))
              .then((value) async {
            await libprovider
                .fetch_library_books(auth.token)
                .then((value) async {
              await libprovider.fetch_reserved_books(auth.token);
            });
          });
          ;
        },
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Card(
              elevation: 10,
              child: Hero(
                  tag: id,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        return const Center(child: LinearProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('Some errors occurred!'),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
