import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/task_list/entry.dart';
import 'package:material_task_tracker/ui/task/task_screen.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  final List<Task> taskList;

  const TaskList({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (_) async {
            final result = await context.read<HomeViewModel>().deleteTask(
              taskList[index],
            );
            if (context.mounted) {
              if (result.isSuccess()) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text('Task deleted'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to delete task'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          },

          key: ValueKey(taskList[index].id),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(
                    task: taskList[index],
                  ),
                ),
              );
            },
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
