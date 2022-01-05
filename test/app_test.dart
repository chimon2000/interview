// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interview/main.dart';
import 'package:interview/src/app.dart';
import 'package:interview/src/books/book_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  group('BooksApp', () {
    testWidgets('renders successfully', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(ProviderScope(
        overrides: [sharedPreferencesRef.overrideWithValue(prefs)],
        child: BooksApp(),
      ));

      await tester.pumpAndSettle();

      expect(find.byType(BooksApp), findsWidgets);
      expect(find.byType(BookListView), findsWidgets);
    });
  });
}
