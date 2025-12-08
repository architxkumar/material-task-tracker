import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/responsive_dialog.dart';
import 'package:material_task_tracker/ui/home/widgets/task_list/entry.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  final List<Task> taskList;

  const TaskList({super.key, required this.taskList});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleTaskDismiss(BuildContext context, Task task) async {
    final result = await context.read<HomeViewModel>().deleteTask(task);
    if (context.mounted) {
      if (result.isSuccess()) {
        _showSnackBar(context, 'Task deleted');
      } else {
        _showSnackBar(context, 'Failed to delete task');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        final Task task = taskList[index];
        return Dismissible(
          onDismissed: (_) async => await _handleTaskDismiss(context, task),
          key: ValueKey(task.id),
          child: GestureDetector(
            onTap: () async {
              context.read<HomeViewModel>().setSelectedTask(task);
              await showDialog<void>(
                context: context,
                builder: (context) => const TaskDetailResponsiveDialog(),
              );
              if (context.mounted) {
                context.read<HomeViewModel>().clearSelectedTask();
              }
            },
            child: TaskListEntry(
              key: ValueKey(task.completed),
              task: task,
              onChanged: context.read<HomeViewModel>().updateTask,
            ),
          ),
        );
      },
    );
  }
}
