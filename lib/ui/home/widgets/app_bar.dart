import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Task> taskList;

  const HomeAppBar({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    final completedTasks = taskList.where((task) => task.completed).length;
    final pendingTasks = taskList.length - completedTasks;
    final String subtitle = (completedTasks != 0)
        ? '$pendingTasks active · $completedTasks completed'
        : '$pendingTasks active';

    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
      child: SafeArea(
        child: Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Material Task Tracker',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(129);
}

/// A more compact version of the HomeAppBar without a subtitle.
/// Used for loading and error states.
class HomeAppBarCompact extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarCompact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
      child: SafeArea(
        child: Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Material Task Tracker',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(129);
}
