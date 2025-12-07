import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/body_section.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/footer_section.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/header_section.dart';
import 'package:provider/provider.dart';

class TaskDetailContainer extends StatefulWidget {

  const TaskDetailContainer({super.key});

  @override
  State<TaskDetailContainer> createState() => _TaskDetailContainerState();
}

class _TaskDetailContainerState extends State<TaskDetailContainer> {
  late Task selectedTask;

  @override
  void initState() {
    super.initState();
     selectedTask = context.read<HomeViewModel>().selectedTask!;
  }


  @override
  void dispose() {
    context.read<HomeViewModel>().clearSelectedTask();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TaskDetailHeaderSection(title: selectedTask.title),
          const SizedBox(
            height: 16,
          ),
          const Divider(),
          const SizedBox(height: 16.0),
          TaskDetailBodySection(
            task: selectedTask,
          ),
          const SizedBox(height: 16,),
          const Divider(),
          const TaskDetailFooterSection()
        ],
      ),
    );
  }

}
