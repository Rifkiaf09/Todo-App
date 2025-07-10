class Todo {
  final int? id;
  final String title;
  final String description;
  final DateTime deadline;
  final String category;
  final bool isDone;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.category,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'category': category,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline: DateTime.parse(map['deadline']),
      category: map['category'],
      isDone: map['isDone'],
    );
  }

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? deadline,
    String? category,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      category: category ?? this.category,
      isDone: isDone ?? this.isDone,
    );
  }
}
