import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:checkly/main.dart';

void main() {
  testWidgets('Checkly header and initial task test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ChecklyApp());

    // Verify that our app shows the new title.
    expect(find.text('Checkly'), findsOneWidget);

    // Verify that our app shows initial tasks.
    expect(find.text('Buy groceries'), findsOneWidget);

    // Verify FAB exists with Cupertino icon
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(cupertino.CupertinoIcons.add), findsOneWidget);
  });

  testWidgets('Add todo test', (WidgetTester tester) async {
    await tester.pumpWidget(const ChecklyApp());

    // Tap the FAB.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(); // Wait for bottom sheet

    // Enter a task name.
    await tester.enterText(find.byType(TextField), 'Buy milk');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle(); // Wait for animation and list update

    // Verify that the task is added to the list.
    // Note: Since new tasks are added to the top (and default to 'Personal' or selected), 
    // and default filter is 'All', it should be visible.
    expect(find.text('Buy milk'), findsOneWidget);
  });

  testWidgets('Filter functionality test', (WidgetTester tester) async {
    await tester.pumpWidget(const ChecklyApp());

    // Verify 'Buy groceries' (Shopping) is visible initially (All filter).
    expect(find.text('Buy groceries'), findsOneWidget);

    // Tap on 'Work' filter (index 1).
    await tester.tap(find.text('Work'));
    await tester.pumpAndSettle();

    // Verify 'Buy groceries' (Shopping) is hidden.
    expect(find.text('Buy groceries'), findsNothing);

    // Verify 'Finish design' (Work) is visible.
    expect(find.text('Finish design'), findsOneWidget);

    // Tap on 'All' filter (index 0).
    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();

    // Verify 'Buy groceries' is visible again.
    expect(find.text('Buy groceries'), findsOneWidget);
  });

  testWidgets('Add todo with specific category test', (WidgetTester tester) async {
    await tester.pumpWidget(const ChecklyApp());

    // Tap the FAB.
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Verify category chips are visible (in filter list).
    expect(find.text('Work'), findsAtLeastNWidgets(1));
    expect(find.text('Shopping'), findsAtLeastNWidgets(1));

    // Tap Dropdown to open menu
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();

    // Tap 'Shopping' item in the dropdown menu
    await tester.tap(find.text('Shopping').last);
    await tester.pumpAndSettle();

    // Enter a task name.
    await tester.enterText(find.byType(TextField).first, 'Buy apples');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Verify 'Buy apples' is in the list (since default filter is All).
    expect(find.text('Buy apples'), findsOneWidget);

    // Filter by 'Shopping' (The main list filter items are InkWells).
    await tester.tap(find.widgetWithText(InkWell, 'Shopping'));
    await tester.pumpAndSettle();
    expect(find.text('Buy apples'), findsOneWidget);

    // Filter by 'Work'.
    await tester.tap(find.widgetWithText(InkWell, 'Work'));
    await tester.pumpAndSettle();
    expect(find.text('Buy apples'), findsNothing);
  });

  testWidgets('Add new category test', (WidgetTester tester) async {
    await tester.pumpWidget(const ChecklyApp());

    // Open Add Task Sheet
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Tap Dropdown to open menu
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();

    // Tap 'New Category' item in the dropdown menu.
    // Note: The text is 'New Category' inside a Row with an Icon.
    // The dialog title is also 'New Category', so we need .last or careful finding.
    await tester.tap(find.text('New Category').last); 
    await tester.pumpAndSettle();

    // Enter new category name in dialog
    await tester.enterText(find.byType(TextField).last, 'Groceries'); 
    await tester.tap(find.text('Add Category')); 
    await tester.pumpAndSettle();

    // Verify 'Groceries' is displayed (in dropdown and potentially main list)
    expect(find.text('Groceries'), findsAtLeastNWidgets(1));

    // Enter task name
    await tester.enterText(find.byType(TextField).first, 'Buy milk');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Verify task is added
    expect(find.text('Buy milk'), findsOneWidget);

    // Verify new category filter exists in main list and filter by it
    await tester.tap(find.widgetWithText(InkWell, 'Groceries'));
    await tester.pumpAndSettle();
    
    // Verify task is visible under new filter
    expect(find.text('Buy milk'), findsOneWidget);
  });
}
