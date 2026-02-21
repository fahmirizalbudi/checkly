import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    expect(find.text('Checkly'), findsOneWidget);
    expect(find.text('Welcome back!'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();

    expect(find.text('Your Tasks'), findsOneWidget);
    expect(find.text('No tasks for today'), findsOneWidget);
  });

  testWidgets('Add todo test', (WidgetTester tester) async {
    final mockStorage = MockStorageService();
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Buy milk');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();

    expect(find.text('Buy milk'), findsOneWidget);
  });

  testWidgets('Filter functionality test', (WidgetTester tester) async {
    final mockStorage = MockStorageService();
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Shopping').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Buy groceries');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Work').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Finish design');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();

    expect(find.text('Buy groceries'), findsOneWidget);

    await tester.tap(find.widgetWithText(InkWell, 'Work'));
    await tester.pumpAndSettle();

    expect(find.text('Buy groceries'), findsNothing);
    expect(find.text('Finish design'), findsOneWidget);

    await tester.tap(find.widgetWithText(InkWell, 'All'));
    await tester.pumpAndSettle();

    expect(find.text('Buy groceries'), findsOneWidget);
  });

  testWidgets('Add todo with specific category test', (WidgetTester tester) async {
    final mockStorage = MockStorageService();
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Shopping').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Buy apples');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();

    expect(find.text('Buy apples'), findsOneWidget);

    await tester.tap(find.widgetWithText(InkWell, 'Shopping'));
    await tester.pumpAndSettle();
    expect(find.text('Buy apples'), findsOneWidget);

    await tester.tap(find.widgetWithText(InkWell, 'Work'));
    await tester.pumpAndSettle();
    expect(find.text('Buy apples'), findsNothing);
  });

  testWidgets('Add new category test', (WidgetTester tester) async {
    final mockStorage = MockStorageService();
    await tester.pumpWidget(MaterialApp(home: HomeScreen(storage: mockStorage)));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('New Category').last); 
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'Groceries'); 
    await tester.tap(find.text('Add Category')); 
    await tester.pumpAndSettle();

    expect(find.text('Groceries'), findsAtLeastNWidgets(1));

    await tester.enterText(find.byType(TextField).first, 'Buy milk');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();

    expect(find.text('Buy milk'), findsOneWidget);

    await tester.tap(find.widgetWithText(InkWell, 'Groceries'));
    await tester.pumpAndSettle();
    
    expect(find.text('Buy milk'), findsOneWidget);
  });
}
