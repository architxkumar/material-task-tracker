import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:result_dart/result_dart.dart';

class TaskListEntry extends StatefulWidget {
  final Task task;
  final Future<Result<bool>> Function(Task) onChanged;

  const TaskListEntry({super.key, required this.task, required this.onChanged});

  @override
  State<TaskListEntry> createState() => _TaskListEntryState();
}

class _TaskListEntryState extends State<TaskListEntry> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.completed;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.task.title,
        style: TextStyle(
          decoration: isChecked
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        shape: const CircleBorder(),
        value: isChecked,
        onChanged: (value) async {
          final result = await widget.onChanged(
            Task(
              id: widget.task.id,
              title: widget.task.title,
              body: widget.task.body,
              completed: value ?? false,
              dueDate: widget.task.dueDate,
              createdAt: widget.task.createdAt,
              updatedAt: DateTime.now(),
              sortOrder: widget.task.sortOrder,
            ),
          );
          if (result.isSuccess()) {
            setState(() {
              isChecked = value ?? false;
            });
          }
        },
      ),
    );
  }
}
