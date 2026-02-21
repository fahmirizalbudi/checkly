import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class StorageService {
  static const String _todosKey = 'todos';
  static const String _categoriesKey = 'categories';

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(todos.map((e) => e.toJson()).toList());
    await prefs.setString(_todosKey, encodedData);
  }

  Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_todosKey);
    if (encodedData == null) return [];
    
    final List<dynamic> decodedData = jsonDecode(encodedData);
    return decodedData.map((e) => Todo.fromJson(e)).toList();
  }

  Future<void> saveCategories(List<String> categories) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_categoriesKey, categories);
  }

  Future<List<String>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_categoriesKey) ?? ['All', 'Work', 'Personal', 'Shopping', 'Fitness'];
  }
}
