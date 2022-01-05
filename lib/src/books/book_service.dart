import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview/main.dart';
import 'package:interview/src/books/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookService {
  BookService(this.prefs);

  final SharedPreferences prefs;
  late var books =
      prefs.getStringList('books')?.map((e) => Book.fromJson(e)).toList() ?? [];

  Future<List<Book>> getBooks() async {
    print('get books');

    await Future.delayed(Duration(seconds: 1));

    return books;
  }

  Future<Book?> getBook(String id) async {
    print('get book $id');

    try {
      final book = books.firstWhere((e) => e.id == id);
      await Future.delayed(Duration(seconds: 1));

      return book;
    } catch (e) {
      return null;
    }
  }

  Future<Book> addBook({
    required String author,
    required String title,
  }) async {
    print('add book');

    final book = Book(
      id: '${books.length + 1}',
      author: author,
      title: title,
    );

    books = [
      ...books,
      book,
    ];
    _save();

    print('added book');

    return book;
  }

  Future<Book> updateBook({
    required Book book,
  }) async {
    print('update book');

    books = books.map((e) => e.id == book.id ? book : e).toList();
    _save();

    print('updated book');

    return book;
  }

  Future<void> _save() async {
    await prefs.setStringList('books', books.map((e) => e.toJson()).toList());
  }
}

final bookServiceRef = Provider<BookService>((ref) {
  return BookService(ref.read(sharedPreferencesRef));
});
