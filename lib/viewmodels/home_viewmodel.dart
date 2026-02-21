import 'package:flutter/foundation.dart';
import '../models/todo.dart';
import '../services/storage_service.dart';

/// ViewModel for the Home Screen.
///
/// Manages the state of todos, categories, and loading status.
/// Handles business logic for adding, toggling, and deleting tasks.
class HomeViewModel extends ChangeNotifier {
  final StorageService _storage;

  List<Todo> _todos = [];
  List<String> _categories = [
    'All',
    'Work',
    'Personal',
    'Shopping',
    'Fitness'
  ];
  bool _isLoading = false;

  /// Creates a [HomeViewModel] instance.
  ///
  /// [storage] can be injected for testing purposes.
  HomeViewModel({StorageService? storage})
      : _storage = storage ?? StorageService() {
    _loadData();
  }

  /// Returns the unmodifiable list of todos.
  List<Todo> get todos => List.unmodifiable(_todos);

  /// Returns the unmodifiable list of categories.
  List<String> get categories => List.unmodifiable(_categories);

  /// Returns the loading status.
  bool get isLoading => _isLoading;

  /// Loads initial data from storage.
  Future<void> _loadData() async {
    try {
      final loadedCategories = await _storage.getCategories();
      final loadedTodos = await _storage.getTodos();

      if (loadedCategories.isNotEmpty) {
        _categories = loadedCategories;
      }
      _todos = loadedTodos;
    } catch (e) {
      debugPrint('Error loading data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new todo item.
  ///
  /// [title] is the task description.
  /// [category] is the optional category; defaults to 'Personal' or selected.
  void addTodo(String title, {String? category}) {
    if (title.isEmpty) return;

    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
      category: category ?? 'Personal',
    );

    _todos.insert(0, newTodo);
    _saveTodos();
    notifyListeners();
  }

  /// Toggles the completion status of a todo item.
  void toggleTodo(Todo todo) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index].isDone = !_todos[index].isDone;
      _saveTodos();
      notifyListeners();
    }
  }

  /// Deletes a todo item.
  void deleteTodo(Todo todo) {
    _todos.remove(todo);
    _saveTodos();
    notifyListeners();
  }

  /// Adds a new category if it doesn't already exist.
  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
      _storage.saveCategories(_categories);
      notifyListeners();
    }
  }

  /// Persists the current list of todos to storage.
  void _saveTodos() {
    _storage.saveTodos(_todos);
  }
}
