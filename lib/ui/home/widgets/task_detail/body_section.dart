import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/description_field.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/due_date.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/time_labe.dart';
import 'package:provider/provider.dart';

class TaskDetailBodySection extends StatelessWidget {
  const TaskDetailBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DueDateField(),
            const SizedBox(
              height: 24,
            ),
            const DescriptionField(),
            const SizedBox(
              height: 24,
            ),
            const Divider(),
            const SizedBox(
              height: 16,
            ),
            TimeLabel(
              label: 'Created',
              dateTime: context
                  .watch<HomeViewModel>()
                  .selectedTask
                  ?.createdAt,
            ),
            const SizedBox(
              height: 8,
            ),
            TimeLabel(
              label: 'Last Updated',
              dateTime: context
                  .watch<HomeViewModel>()
                  .selectedTask
                  ?.updatedAt,
            ),
          ],
        ),
      ),
    );
  }
}
