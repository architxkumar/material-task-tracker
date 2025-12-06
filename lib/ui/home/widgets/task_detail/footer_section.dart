import 'package:flutter/material.dart';

class TaskDetailFooterSection extends StatelessWidget {
  const TaskDetailFooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(24.0),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
      ),
      onPressed: () {},
      label: Text('Delete'),
      icon: Icon(Icons.delete),
    );
  }
}
