import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview/src/books/controllers/book_detail_view_controller.dart';

class BookDetailsView extends ConsumerWidget {
  const BookDetailsView({Key? key}) : super(key: key);

  static const routeName = '/book';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookDetailViewControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
    );
  }
}
