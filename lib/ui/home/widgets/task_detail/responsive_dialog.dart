import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/container.dart';

class TaskDetailResponsiveDialog extends StatelessWidget {
  final Task task;

  const TaskDetailResponsiveDialog({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => (constraints.maxWidth > 600)
          ? Dialog(
              constraints: const BoxConstraints(maxWidth: 750),
              child: TaskDetailContainer(task: task),
            )
          // FIX: Use DraggableScrollableSheet here
          : Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.bottomCenter,
              child: TaskDetailContainer(task: task),
            ),
    );
  }
}
