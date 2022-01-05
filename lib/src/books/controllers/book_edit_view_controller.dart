import 'package:interview/src/books/book.dart';
import 'package:riverpod/riverpod.dart';

import '../book_service.dart';

class BookDetailViewController extends StateNotifier<BookDetailState> {
  BookDetailViewController(this.service) : super(AsyncValue.loading());

  final BookService service;

  Future<Book?> getBook(String? id) async {
    if (id == null) {
      state = AsyncValue.data(null);
      return null;
    }

    final book = await service.getBook(id);
    state = AsyncValue.data(book);

    return book;
  }

  Future<Book> addBook({
    required String author,
    required String title,
  }) async {
    return service.addBook(
      author: author,
      title: title,
    );
  }

  Future<Book> updateBook({
    required Book book,
  }) async {
    return service.updateBook(book: book);
  }
}

final bookEditViewControllerRef =
    StateNotifierProvider<BookDetailViewController, BookDetailState>((ref) {
  return BookDetailViewController(ref.read(bookServiceRef));
});

typedef BookDetailState = AsyncValue<Book?>;
