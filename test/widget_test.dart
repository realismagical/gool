// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gool/main.dart' as main_game;

void main() {
  testWidgets('Widget created', (WidgetTester tester) async {
    final game = main_game.Game();
    await tester.pumpWidget(GameWidget(game: game));
    expect(find.byWidgetPredicate((widget) => widget is GameWidget), findsOneWidget);
  });
}
