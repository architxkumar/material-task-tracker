import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeAppBarFilterCard extends StatelessWidget {
  const HomeAppBarFilterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: context
                  .read<HomeViewModel>()
                  .onHideCompletedTasksIconPressed,
              child: Row(
                spacing: 8.0,
                children: [
                  (context
                      .watch<HomeViewModel>()
                      .appBarUiState
                      .isHideCompletedTasksIconActive)
                      ? const Icon(Icons.check_circle_outline)
                      : const Icon(Icons.circle_outlined),
                  Text(
                    'Hide Completed Tasks',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
