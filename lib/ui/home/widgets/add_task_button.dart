import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/task_dialog.dart';
import 'package:provider/provider.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => TaskDialog(
            widgetLabel: 'Add Task',
            submitButtonLabel: 'Save',
            onPressingSaveButton: context.read<HomeViewModel>().insertTask,
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
