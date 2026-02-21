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
}
