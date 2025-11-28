import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/task/widget/task_metadata_entry.dart';

class TaskMetadataBody extends StatelessWidget {
  final Task task;
  const TaskMetadataBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.0,
          children: [
            TaskMetaDataEntry(
              icon: Icons.calendar_today,
              body: task.dueDate != null
                  ? '${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}'
                  : 'No due date',
              label: 'Due Date',
            ),
            TaskMetaDataEntry(
              icon: Icons.add_circle_outline,
              body:
                  '${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year} ${task.createdAt.hour}:${task.createdAt.minute.toString().padLeft(2, '0')}',
              label: 'Created At',
            ),
            TaskMetaDataEntry(
              icon: Icons.update,
              body:
                  '${task.updatedAt.day}/${task.updatedAt.month}/${task.updatedAt.year} ${task.updatedAt.hour}:${task.updatedAt.minute.toString().padLeft(2, '0')}',
              label: 'Updated At',
            ),
          ],
        ),
      ),
    );
  }
}
