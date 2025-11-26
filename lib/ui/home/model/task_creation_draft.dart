class TaskCreationDraft {
  final String title;
  final String? body;
  final bool completed;
  TaskCreationDraft({
    required this.title,
    this.body,
    this.completed = false,
  });

  TaskCreationDraft copyWith({
    String? title,
    String? body,
    bool? completed,
    DateTime? dueDate,
  }) {
    return TaskCreationDraft(
      title: title ?? this.title,
      body: body ?? this.body,
      completed: completed ?? this.completed,
    );
  }
}
