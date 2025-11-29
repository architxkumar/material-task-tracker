import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/task_detail/task_detail_view_model.dart';
import 'package:material_task_tracker/ui/task_detail/widget/app_bar.dart';
import 'package:material_task_tracker/ui/task_detail/widget/description_section.dart';
import 'package:material_task_tracker/ui/task_detail/widget/metadata_section.dart';
import 'package:material_task_tracker/ui/task_detail/widget/title_header.dart';
import 'package:provider/provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TaskDetailAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TaskDetailTitleHeader(),
              TaskDetailMetadataSection(),
              TaskDetailDescriptionSection(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TaskDetailViewModel>().loadTask(widget.task);
  }
}
