import 'package:flutter/material.dart';

class TaskSummaryHeader extends StatelessWidget {
  final int completedTaskCount;
  final int totalTaskCount;

  const TaskSummaryHeader({
    super.key,
    required this.completedTaskCount,
    required this.totalTaskCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Completed $completedTaskCount out of $totalTaskCount tasks',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
