import 'package:album_finder/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Router Tests',
    () {
      testWidgets(
        'Navigates to HomeScreen on / path',
        (WidgetTester tester) async {
          final router = buildRouter();
          await tester.pumpWidget(
            MaterialApp.router(
              routerConfig: router,
            ),
          );

          router.go('/');
          await tester.pumpAndSettle();

          expect(find.text('Home Screen'), findsOneWidget);
          expect(find.text('home screen!!!!!!'), findsOneWidget);
        },
      );

      testWidgets(
        'Navigates to LibraryScreen on /libraries path',
        (WidgetTester tester) async {
          final router = buildRouter();
          await tester.pumpWidget(
            MaterialApp.router(
              routerConfig: router,
            ),
          );

          router.go('/libraries');
          await tester.pumpAndSettle();

          expect(find.text('Library Screen'), findsOneWidget);
          expect(find.text('library screen!!!!!!'), findsOneWidget);
        },
      );

      testWidgets(
        'BottomNavigationBar switches to HomeScreen',
        (WidgetTester tester) async {
          final router = buildRouter();
          await tester.pumpWidget(
            MaterialApp.router(
              routerConfig: router,
            ),
          );

          router.go('/libraries');
          await tester.pumpAndSettle();

          await tester.tap(find.text('home'));
          await tester.pumpAndSettle();

          expect(find.text('Home Screen'), findsOneWidget);
          expect(find.text('home screen!!!!!!'), findsOneWidget);
        },
      );

      testWidgets(
        'BottomNavigationBar switches to LibraryScreen',
        (WidgetTester tester) async {
          final router = buildRouter();
          await tester.pumpWidget(
            MaterialApp.router(
              routerConfig: router,
            ),
          );

          await tester.tap(find.text('library'));
          await tester.pumpAndSettle();

          expect(find.text('Library Screen'), findsOneWidget);
          expect(find.text('library screen!!!!!!'), findsOneWidget);
        },
      );
    },
  );
}
