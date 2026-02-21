import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:checkly/main.dart';

void main() {
  testWidgets('Todo list initial state test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ChecklyApp());

    // Verify that our app starts with the empty state message.
    expect(find.text('No tasks yet. Add one!'), findsOneWidget);
    expect(find.byIcon(Icons.checklist_rounded), findsOneWidget);

    // Verify that there are no cards/list items initially.
    expect(find.byType(Card), findsNothing);
  });

  testWidgets('Add todo test', (WidgetTester tester) async {
    await tester.pumpWidget(const ChecklyApp());

    // Tap the 'New Task' button.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Enter a task name.
    await tester.enterText(find.byType(TextField), 'Buy milk');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Verify that the task is added to the list.
    expect(find.text('Buy milk'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
  });
}
