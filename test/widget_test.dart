import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:checkly/main.dart';
import 'package:checkly/services/storage_service.dart';
import 'package:checkly/models/todo.dart';
import 'package:checkly/screens/home_screen.dart';

class MockStorageService implements StorageService {
  List<Todo> todos = [];
  List<String> categories = ['All', 'Work', 'Personal', 'Shopping', 'Fitness'];

  @override
  Future<List<String>> getCategories() async {
    return categories;
  }

  @override
  Future<List<Todo>> getTodos() async {
    return todos;
  }

  @override
  Future<void> saveCategories(List<String> categories) async {
    this.categories = categories;
  }

  @override
  Future<void> saveTodos(List<Todo> todos) async {
    this.todos = todos;
  }
}

void main() {
  testWidgets('Checkly header and initial task test', (WidgetTester tester) async {
    final mockStorage = MockStorageService();
    // No todos initially
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    // Verify Home Tab elements
    expect(find.text('Checkly'), findsOneWidget);
    expect(find.text('Welcome back!'), findsOneWidget);

    // Verify FAB exists
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Navigate to Tasks Tab
    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();

    // Verify Tasks Tab elements
    expect(find.text('Your Tasks'), findsOneWidget);
    expect(find.text('No tasks for today'), findsOneWidget);
  });

  testWidgets('Add todo test', (WidgetTester tester) async {
    final mockStorage = MockStorageService();
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    // Tap the FAB (on Home tab).
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Enter a task name.
    await tester.enterText(find.byType(TextField), 'Buy milk');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Navigate to Tasks Tab to verify
    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();

    // Verify that the task is added to the list.
    expect(find.text('Buy milk'), findsOneWidget);
  });

  testWidgets('Filter functionality test', (WidgetTester tester) async {
    final mockStorage = MockStorageService();
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    // Add 'Buy groceries' (Shopping)
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Shopping').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Buy groceries');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Add 'Finish design' (Work)
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Work').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Finish design');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Navigate to Tasks Tab first
    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();

    // Verify 'Buy groceries' (Shopping) is visible initially (All filter).
    expect(find.text('Buy groceries'), findsOneWidget);

    // Tap on 'Work' filter.
    await tester.tap(find.widgetWithText(InkWell, 'Work'));
    await tester.pumpAndSettle();

    // Verify 'Buy groceries' (Shopping) is hidden.
    expect(find.text('Buy groceries'), findsNothing);

    // Verify 'Finish design' (Work) is visible.
    expect(find.text('Finish design'), findsOneWidget);

    // Tap on 'All' filter (index 0).
    await tester.tap(find.widgetWithText(InkWell, 'All'));
    await tester.pumpAndSettle();

    // Verify 'Buy groceries' is visible again.
    expect(find.text('Buy groceries'), findsOneWidget);
  });

  testWidgets('Add todo with specific category test', (WidgetTester tester) async {
    final mockStorage = MockStorageService();
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    // Tap the FAB (Home tab).
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

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

    // Navigate to Tasks Tab
    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();

    // Verify 'Buy apples' is in the list.
    expect(find.text('Buy apples'), findsOneWidget);

    // Filter by 'Shopping'.
    await tester.tap(find.widgetWithText(InkWell, 'Shopping'));
    await tester.pumpAndSettle();
    expect(find.text('Buy apples'), findsOneWidget);

    // Filter by 'Work'.
    await tester.tap(find.widgetWithText(InkWell, 'Work'));
    await tester.pumpAndSettle();
    expect(find.text('Buy apples'), findsNothing);
  });

  testWidgets('Add new category test', (WidgetTester tester) async {
    final mockStorage = MockStorageService();
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    // Open Add Task Sheet (Home tab)
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Tap Dropdown to open menu
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();

    // Tap 'New Category' item.
    await tester.tap(find.text('New Category').last); 
    await tester.pumpAndSettle();

    // Enter new category name in dialog
    await tester.enterText(find.byType(TextField).last, 'Groceries'); 
    await tester.tap(find.text('Add Category')); 
    await tester.pumpAndSettle();

    // Verify 'Groceries' is displayed (in dropdown)
    expect(find.text('Groceries'), findsAtLeastNWidgets(1));

    // Enter task name
    await tester.enterText(find.byType(TextField).first, 'Buy milk');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Navigate to Tasks Tab
    await tester.tap(find.text('Tasks'));
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
