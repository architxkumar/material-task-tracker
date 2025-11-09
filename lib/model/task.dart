class Task {
  final int? id;
  final String title;
  final String? body;
  final bool? completed;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? sortOrder;

  Task({
    this.id,
    required this.title,
    this.body,
    this.completed,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
    this.sortOrder,
  });
}
