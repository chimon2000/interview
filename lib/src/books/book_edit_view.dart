import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview/src/books/book.dart';
import 'package:interview/src/books/controllers/book_list_view_controller.dart';
import 'package:routemaster/routemaster.dart';

import 'controllers/book_edit_view_controller.dart';

class BookEditView extends ConsumerStatefulWidget {
  const BookEditView({
    Key? key,
    this.id,
  }) : super(key: key);

  final String? id;

  @override
  _BookEditViewState createState() => _BookEditViewState();
}

class _BookEditViewState extends ConsumerState<BookEditView> {
  late final controller = ref.read(bookEditViewControllerRef.notifier);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.getBook(widget.id);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookEditViewControllerRef);

    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: state.when(
        data: (book) => BookForm(
          book: book,
          onSubmit: ({
            required title,
            required author,
            imageUrl,
          }) async {
            final bookEditViewController =
                ref.read(bookEditViewControllerRef.notifier);
            final bookListViewController =
                ref.read(booklistViewControllerRef.notifier);

            if (book != null) {
              final updated = book.copyWith(
                author: author,
                title: title,
                imageUrl: imageUrl,
              );

              await bookEditViewController.updateBook(book: updated);
            } else {
              await bookEditViewController.addBook(
                  author: author, title: title);
            }

            await bookListViewController.getBooks();
            Routemaster.of(context).pop();
          },
        ),
        error: (_, __) => Container(),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class BookForm extends StatefulWidget {
  BookForm({
    Key? key,
    this.book,
    required this.onSubmit,
  }) : super(key: key);

  final Book? book;
  final Function({
    required String author,
    required String title,
    String? imageUrl,
  }) onSubmit;

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  late final titleController = TextEditingController(text: widget.book?.title);
  late final authorController =
      TextEditingController(text: widget.book?.author);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(8),
        children: [
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextFormField(
            controller: authorController,
            decoration: InputDecoration(
              labelText: 'Author',
            ),
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: Text('Save'),
          )
        ],
      ),
    );
  }

  void _handleSubmit() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      widget.onSubmit(
        title: titleController.text,
        author: authorController.text,
      );
    }
  }
}
