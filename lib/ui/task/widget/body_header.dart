import 'package:flutter/material.dart';

class TaskScreenBodyHeaderCard extends StatelessWidget {
  final String taskTitle;
  const TaskScreenBodyHeaderCard({super.key, required this.taskTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            Checkbox(
              shape: const CircleBorder(),
              value: false,
              onChanged: (bool? value) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  taskTitle,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
