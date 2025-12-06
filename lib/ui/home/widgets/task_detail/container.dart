import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/body_section.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/footer_section.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/header_section.dart';

class TaskDetailContainer extends StatefulWidget {
  final Task task;

  const TaskDetailContainer({super.key, required this.task});

  @override
  State<TaskDetailContainer> createState() => _TaskDetailContainerState();
}

class _TaskDetailContainerState extends State<TaskDetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TaskDetailHeaderSection(title: widget.task.title),
          const SizedBox(
            height: 16,
          ),
          const Divider(),
          SizedBox(height: 16.0),
          TaskDetailBodySection(
            task: widget.task,
          ),
          SizedBox(height: 16,),
          Divider(),
          TaskDetailFooterSection()
        ],
      ),
    );
  }
}
