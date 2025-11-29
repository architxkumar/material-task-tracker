import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/task_detail/task_detail_view_model.dart';
import 'package:provider/provider.dart';

class TaskDetailDescriptionSection extends StatelessWidget {
  const TaskDetailDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Notes', style: Theme.of(context).textTheme.titleMedium),
              Text(
                context.watch<TaskDetailViewModel>().task.body ??
                    'No description provided.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
