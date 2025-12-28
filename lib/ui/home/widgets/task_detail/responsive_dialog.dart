import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/container.dart';

class TaskDetailResponsiveDialog extends StatelessWidget {

  const TaskDetailResponsiveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => (constraints.maxWidth > 600)
          ? const Dialog(
              constraints: BoxConstraints(maxWidth: 750),
              child: TaskDetailContainer(),
            )
          // FIX: Use DraggableScrollableSheet here
          : Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.bottomCenter,
              child: const TaskDetailContainer(),
            ),
    );
  }
}
