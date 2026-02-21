/// Model class representing a single Todo task.
class Todo {
  /// Unique identifier for the todo.
  String id;

  /// The description of the task.
  String title;

  /// Whether the task is completed.
  bool isDone;

  /// The category this task belongs to.
  String category;

  /// The timestamp when the task was created.
  DateTime createdAt;

  /// Creates a [Todo] instance.
  ///
  /// [id] and [title] are required.
  /// [isDone] defaults to false.
  /// [category] defaults to 'Personal'.
  /// [createdAt] defaults to current time if not provided.
  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    this.category = 'Personal',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Converts the [Todo] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Creates a [Todo] instance from a JSON map.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
      category: json['category'] ?? 'Personal',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
