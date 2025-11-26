import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/widgets/task_creation/modal.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const TaskCreationModal(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
