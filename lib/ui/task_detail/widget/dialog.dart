import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/task_detail/task_detail_view_model.dart';
import 'package:provider/provider.dart';

class TaskDetailConfirmationDialog extends StatelessWidget {
  const TaskDetailConfirmationDialog({super.key});

  Future<void> handleDeletion(BuildContext context) async {
    final result = await context.read<TaskDetailViewModel>().deleteTask();
    if (context.mounted) {
      (result.isSuccess())
          ? Navigator.of(context).pop(true)
          : Navigator.of(context).pop(false);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.delete_forever),
      title: const Text('Delete task?'),
      content: const Text('This task will be removed permanently.'),
      actions: [
        TextButton(
          onPressed: (context.watch<TaskDetailViewModel>().isLoading)
              ? null
              : () {
                  Navigator.pop(context);
                },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: (context.watch<TaskDetailViewModel>().isLoading)
              ? null
              : () async => await handleDeletion(context),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
