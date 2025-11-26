import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/task_creation/field.dart';
import 'package:provider/provider.dart';

class TaskCreationModalBody extends StatelessWidget {
  final TextEditingController _taskTitleFieldController;
  final TextEditingController _taskBodyFieldController;

  const TaskCreationModalBody({
    required TextEditingController taskTitleFieldController,
    required TextEditingController taskBodyFieldController,
    super.key,
  }) : _taskTitleFieldController = taskTitleFieldController,
       _taskBodyFieldController = taskBodyFieldController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16.0,
      children: [
        TaskCreationFormField(
          label: 'Title',
          textEditingController: _taskTitleFieldController,
          onChanged: context.read<HomeViewModel>().onTitleFieldChange,
        ),
        TaskCreationFormField(
          label: 'Body',
          textEditingController: _taskBodyFieldController,
          onChanged: context.read<HomeViewModel>().onBodyFieldChange,
        ),
        Row(
          children: [
            const Text('Completed'),
            const Spacer(),
            Switch(
              value: context.watch<HomeViewModel>().isTaskCompleted,
              onChanged: context
                  .read<HomeViewModel>()
                  .onCompletedCheckboxChange,
            ),
          ],
        ),
      ],
    );
  }
}
