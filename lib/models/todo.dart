class Todo {
  String id;
  String title;
  bool isDone;
  String category;
  DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    this.category = 'Personal',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }

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
