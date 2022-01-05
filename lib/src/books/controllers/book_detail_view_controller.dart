import 'package:interview/src/books/book.dart';
import 'package:riverpod/riverpod.dart';

class BookDetailViewController extends StateNotifier<BookDetailState> {
  BookDetailViewController() : super(AsyncValue.loading());
}

final bookDetailViewControllerProvider =
    StateNotifierProvider<BookDetailViewController, BookDetailState>((ref) {
  return BookDetailViewController();
});

typedef BookDetailState = AsyncValue<Book>;
