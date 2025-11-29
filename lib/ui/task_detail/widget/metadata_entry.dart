import 'package:flutter/material.dart';

class TaskDetailMetadataEntry extends StatelessWidget {
  final IconData icon;
  final String body;
  final String label;

  const TaskDetailMetadataEntry({
    super.key,
    required this.icon,
    required this.body,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16.0,
      children: [
        Icon(icon),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ],
    );
  }
}
