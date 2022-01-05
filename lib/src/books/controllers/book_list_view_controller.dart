import 'package:interview/src/books/book.dart';
import 'package:interview/src/books/book_service.dart';
import 'package:riverpod/riverpod.dart';

class BookListViewController extends StateNotifier<BookListState> {
  BookListViewController(this.service) : super(AsyncValue.loading()) {
    getBooks();
  }

  final BookService service;

  Future<List<Book>> getBooks() async {
    final books = await service.getBooks();
    state = AsyncValue.data(books);

    return books;
  }
}

final booklistViewControllerRef =
    StateNotifierProvider<BookListViewController, BookListState>((ref) {
  return BookListViewController(ref.read(bookServiceRef));
});

typedef BookListState = AsyncValue<List<Book>>;
