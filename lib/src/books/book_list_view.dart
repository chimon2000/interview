import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview/src/books/controllers/book_list_view_controller.dart';
import 'package:routemaster/routemaster.dart';
import 'package:transparent_image/transparent_image.dart';

class BookListView extends ConsumerWidget {
  const BookListView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(booklistViewControllerRef);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: state.when(
        data: (data) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 24,
            ),
            itemBuilder: (context, index) {
              final book = data[index];
              return GestureDetector(
                onTap: () {
                  Routemaster.of(context).push(book.id);
                },
                child: Column(
                  children: [
                    if (book.imageUrl != null)
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 268,
                              height: 401,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              width: 268,
                              height: 401,
                              placeholder: kTransparentImage,
                              image: book.imageUrl!,
                            ),
                          )
                        ],
                      )
                    else
                      Container(
                        width: 268,
                        height: 401,
                        child: Placeholder(
                          fallbackWidth: 268,
                          fallbackHeight: 401,
                        ),
                      ),
                    SizedBox(height: 16),
                    Text(book.title, style: textTheme.headline6),
                    SizedBox(height: 8),
                    Text(book.author),
                  ],
                ),
              );
            },
            itemCount: data.length,
          ),
        ),
        error: (error, stack) => Container(),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Routemaster.of(context).push('new'),
      ),
    );
  }
}
