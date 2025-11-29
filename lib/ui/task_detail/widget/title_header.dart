import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/task_detail/task_detail_view_model.dart';
import 'package:provider/provider.dart';

class TaskDetailTitleHeader extends StatelessWidget {
  const TaskDetailTitleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            Checkbox(
              shape: const CircleBorder(),
              value: false,
              onChanged: (bool? value) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  context.watch<TaskDetailViewModel>().task.title,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
