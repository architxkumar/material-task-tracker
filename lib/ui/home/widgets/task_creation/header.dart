import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class TaskCreationModalHeader extends StatelessWidget {
  final TextEditingController _titleFieldController;

  const TaskCreationModalHeader({
    super.key,
    required TextEditingController titleFieldController,
  }) : _titleFieldController = titleFieldController;

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('Are you sure you want to discard your changes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // close modal
              context.read<HomeViewModel>().onTaskCreationModalDismissal();
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  void _closeModal(BuildContext context) {
    if (_titleFieldController.text.isNotEmpty) {
      _showConfirmationDialog(context);
      return;
    }

    Navigator.pop(context);
    context.read<HomeViewModel>().onTaskCreationModalDismissal();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Text(
          'Create Task',
          style: TextTheme.of(context).titleLarge,
        ),
        IconButton(
          tooltip: 'Close',
          onPressed: (context.watch<HomeViewModel>().isLoading)
              ? null
              : () {
                  _closeModal(context);
                },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
