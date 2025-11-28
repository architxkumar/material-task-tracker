import 'package:flutter/material.dart';

class TaskScreenFAB extends StatelessWidget {
  const TaskScreenFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: const Text('Edit Task'),
      icon: const Icon(Icons.edit),
    );
  }
}
