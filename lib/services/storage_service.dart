import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

/// Service responsible for persisting data to local storage using SharedPreferences.
class StorageService {
  static const String _todosKey = 'todos';
  static const String _categoriesKey = 'categories';

  /// Saves the list of [Todo] items to local storage.
  ///
  /// Serializes the list to JSON before saving.
  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(todos.map((e) => e.toJson()).toList());
    await prefs.setString(_todosKey, encodedData);
  }

  /// Retrieves the list of [Todo] items from local storage.
  ///
  /// Returns an empty list if no data is found.
  Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_todosKey);
    if (encodedData == null) return [];
    
    final List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData.map((e) => Todo.fromJson(e)).toList();
  }

  /// Saves the list of category names to local storage.
  Future<void> saveCategories(List<String> categories) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_categoriesKey, categories);
  }

  /// Retrieves the list of categories from local storage.
  ///
  /// Returns a default list of categories if no data is found.
  Future<List<String>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_categoriesKey) ?? ['All', 'Work', 'Personal', 'Shopping', 'Fitness'];
  }
}
