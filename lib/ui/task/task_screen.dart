import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/task/widget/app_bar.dart';
import 'package:material_task_tracker/ui/task/widget/body_content.dart';
import 'package:material_task_tracker/ui/task/widget/body_header.dart';
import 'package:material_task_tracker/ui/task/widget/task_metadata_body.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskScreenAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TaskScreenBodyHeaderCard(taskTitle: task.title),
                TaskMetadataBody(
                  task: task,
                ),
                TaskDetailBodyContent(
                  content: task.body ?? 'No description provided.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
