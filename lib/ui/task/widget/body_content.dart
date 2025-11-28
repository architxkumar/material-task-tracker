import 'package:flutter/material.dart';

class TaskDetailBodyContent extends StatelessWidget {
  final String content;
  const TaskDetailBodyContent({super.key, required this.content});

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
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}
