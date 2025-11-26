import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class TaskCreationModalActionRow extends StatelessWidget {
  const TaskCreationModalActionRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notification_add),
        ),
        const Spacer(),
        FilledButton(
          onPressed:
              (context
                      .watch<HomeViewModel>()
                      .taskCreationDraft
                      .title
                      .isNotEmpty &&
                  !context.watch<HomeViewModel>().isLoading)
              ? () async {
                  context.read<HomeViewModel>().enableTaskSavingState();
                  final result = await context.read<HomeViewModel>().saveTask();
                  if (result.isError() && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error adding task'),
                      ),
                    );
                  }
                  if (context.mounted) {
                    Navigator.pop(context);
                    context.read<HomeViewModel>().disableTaskSavingState();
                  }
                }
              : null,
          child: (context.watch<HomeViewModel>().isLoading)
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
