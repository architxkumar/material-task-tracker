import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar/app_bar.dart';
import 'package:material_task_tracker/ui/home/widgets/task_creation/button.dart';
import 'package:material_task_tracker/ui/home/widgets/task_list/list.dart';
import 'package:provider/provider.dart';

class HomeContentScreen extends StatelessWidget {
  final List<Task> taskList;

  const HomeContentScreen({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    final filteredTasksList = context.watch<HomeViewModel>().filterTasksList(
      taskList,
    );
    return Scaffold(
      floatingActionButton: const AddTaskButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar needs access to the raw tasks to display count of completed tasks
          HomeAppBar(taskList: taskList),
          (taskList.isEmpty)
              ? const Expanded(
                  child: Center(
                    child: Text('No tasks found'),
                  ),
                )
              : TaskList(
                  taskList: filteredTasksList,
                ),
        ],
      ),
    );
  }
}
