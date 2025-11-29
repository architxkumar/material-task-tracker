import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/task_detail/task_detail_view_model.dart';
import 'package:material_task_tracker/ui/task_detail/widget/metadata_entry.dart'
    as metadata_section;
import 'package:provider/provider.dart';

class TaskDetailMetadataSection extends StatelessWidget {
  const TaskDetailMetadataSection({super.key});

  @override
  Widget build(BuildContext context) {
    final task = context.watch<TaskDetailViewModel>().task;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.0,
          children: [
            metadata_section.TaskDetailMetadataEntry(
              icon: Icons.calendar_today,
              body: task.dueDate != null
                  ? '${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}'
                  : 'No due date',
              label: 'Due Date',
            ),
            metadata_section.TaskDetailMetadataEntry(
              icon: Icons.add_circle_outline,
              body:
                  '${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year} ${task.createdAt.hour}:${task.createdAt.minute.toString().padLeft(2, '0')}',
              label: 'Created At',
            ),
            metadata_section.TaskDetailMetadataEntry(
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
