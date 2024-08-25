class Task {
  final int? id;
  final String title;
  final String? description;
  final String category;
  final bool isCompleted;
  final String createdAt;

  Task({
    this.id,
    required this.title,
    this.description,
    required this.category,
    this.isCompleted = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      isCompleted: map['isCompleted'] == 1,
      createdAt: map['createdAt'],
    );
  }
}
