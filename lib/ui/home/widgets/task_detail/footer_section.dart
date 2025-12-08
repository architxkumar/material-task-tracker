import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/core/ui/snack_bar.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class TaskDetailFooterSection extends StatelessWidget {
  const TaskDetailFooterSection({super.key});

  Future<void> _handleDeleteTask(BuildContext context) async {
    final result = await context.read<HomeViewModel>().deleteTask(
      context.read<HomeViewModel>().selectedTask!,
    );
    if (context.mounted) {
      if (result.isSuccess()) {
        Navigator.of(context).pop();
showFloatingSnackBar(context, 'Task deleted');
      } else {
showFloatingSnackBar(context, 'Failed to delete task');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(24.0),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
      ),
      onPressed: () async => await _handleDeleteTask(context),
      label: const Text('Delete'),
      icon: const Icon(Icons.delete),
    );
  }
}
