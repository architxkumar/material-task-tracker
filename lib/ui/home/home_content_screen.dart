import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar.dart';
import 'package:material_task_tracker/ui/home/widgets/task_creation/button.dart';
import 'package:material_task_tracker/ui/home/widgets/task_list/list.dart';

class HomeContentScreen extends StatelessWidget {
  final List<Task> taskList;

  const HomeContentScreen({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AddTaskButton(),
      appBar: HomeAppBar(taskList: taskList),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (taskList.isEmpty)
              ? const Expanded(
                  child: Center(
                    child: Text('No tasks found'),
                  ),
                )
              : TaskList(taskList: taskList),
        ],
      ),
    );
  }
}
