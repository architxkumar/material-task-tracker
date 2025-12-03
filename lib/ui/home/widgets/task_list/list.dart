import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
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
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (_) async =>
              await _handleTaskDismiss(context, taskList[index]),
          key: ValueKey(taskList[index].id),
          child: GestureDetector(
            onTap: () => {},
            child: TaskListEntry(
              key: ValueKey(taskList[index].completed),
              task: taskList[index],
              onChanged: context.read<HomeViewModel>().updateTask,
            ),
          ),
        ),
      ),
    );
  }
}
