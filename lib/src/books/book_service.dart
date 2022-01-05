import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview/src/books/book.dart';

class BookService {
  List<Book> books = [
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
    print('added book');

    return book;
  }

  Future<Book> updateBook({
    required Book book,
  }) async {
    books = books.map((e) => e.id == book.id ? book : e).toList();

    return book;
  }
}

final bookServiceRef = Provider<BookService>((ref) {
  return BookService();
});
