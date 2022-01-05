import 'package:flutter/material.dart';
import 'package:interview/src/books/books.dart';
import 'package:routemaster/routemaster.dart';

class BooksApp extends StatelessWidget {
  BooksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: RoutemasterParser(),
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
    );
  }
}

final routes = RouteMap(
  routes: {
    '/': (_) => Redirect('/books'),
    '/books': (_) => MaterialPage(child: BookListView()),
    '/books/:id': (_) => MaterialPage(child: BookDetailsView()),
    '/books/:id/edit': (_) => MaterialPage(child: BookEditView()),
    '/books/new': (_) => MaterialPage(child: BookEditView()),
  },
);