import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/sort.dart';
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
    final int itemCount = taskList.length;
    final SortMode sortMode = context
        .watch<HomeViewModel>()
        .appBarUiState
        .sortMode;
    return (sortMode == SortMode.manual)
        ? ReorderableListView.builder(
            itemBuilder: _listItemBuilder,
            itemCount: itemCount,
            onReorder: (oldIndex, newIndex) async {
              final result = await context
                  .read<HomeViewModel>()
                  .reorderTasks(oldIndex, newIndex);
              if (context.mounted) {
                if (result.isSuccess()) {
                  _showSnackBar(context, 'Updated sort order');
                } else {
                  _showSnackBar(context, 'Failed to update sort order');
                }
              }
            },
          )
        : ListView.builder(
            itemBuilder: _listItemBuilder,
            itemCount: itemCount,
          );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
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
          // No need to clear selected task here because everytime a dialog is opened,
          // the selected task is set again.
        },
        child: TaskListEntry(
          key: ValueKey(task.id),
          task: task,
          onChanged: context.read<HomeViewModel>().updateTask,
        ),
      ),
    );
  }
}
