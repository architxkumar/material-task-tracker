import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/task_detail/widget/dialog.dart';

class TaskDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: const EdgeInsets.only(right: 8.0),
      actions: [
        IconButton(
          onPressed: () async {
            final result = await showDialog<bool>(
              context: context,
              builder: (context) => const TaskDetailConfirmationDialog(),
            );
            if (context.mounted) {
              Navigator.of(context).pop(result);
            }
          },
          icon: const Icon(Icons.delete_forever),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
