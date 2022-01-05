import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview/src/app.dart';
import 'package:interview/src/books/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey('books')) {
    await prefs.setStringList('books', _books.map((e) => e.toJson()).toList());
  }

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesRef.overrideWithValue(prefs)],
      child: BooksApp(),
    ),
  );
}

final sharedPreferencesRef = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

List<Book> _books = [
  Book(
    id: 'abc-123',
    title: 'New Spring',
    author: 'Robert Jordan',
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1328959234l/187065.jpg',
  ),
  Book(
    id: 'def-456',
    title: 'The Eye of the World',
    author: 'Robert Jordan',
    imageUrl:
        'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1337818095l/228665.jpg',
  ),
];
