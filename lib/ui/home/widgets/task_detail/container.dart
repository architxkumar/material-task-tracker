import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/body_section.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/footer_section.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/header_section.dart';

class TaskDetailContainer extends StatefulWidget {
  const TaskDetailContainer({super.key});

  @override
  State<TaskDetailContainer> createState() => _TaskDetailContainerState();
}

class _TaskDetailContainerState extends State<TaskDetailContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TaskDetailHeaderSection(),
          SizedBox(
            height: 16,
          ),
          Divider(),
          SizedBox(height: 16.0),
          TaskDetailBodySection(),
          SizedBox(
            height: 16,
          ),
          Divider(),
          TaskDetailFooterSection(),
        ],
      ),
    );
  }
}
