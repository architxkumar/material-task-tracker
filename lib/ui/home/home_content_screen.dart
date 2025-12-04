import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar/app_bar.dart';
import 'package:material_task_tracker/ui/home/widgets/task_creation_field.dart';
import 'package:material_task_tracker/ui/home/widgets/task_list/list.dart';
import 'package:provider/provider.dart';

class HomeContentScreen extends StatelessWidget {
  // HACK: Using class constructor instead of dedicated state object
  // TODO: Look at alternate approach to use state object for holding state for filtered and raw tasks
  final List<Task> taskList;

  const HomeContentScreen({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    final filteredTasksList = context.watch<HomeViewModel>().filterTasksList(
      taskList,
    );
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16.0,
        children: [
          // AppBar needs access to the raw tasks to display count of completed tasks
          HomeAppBar(taskList: taskList),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: const TaskCreationField(),
          ),
          Expanded(
            child: (taskList.isEmpty)
                ? const Center(
                    child: Text('No tasks found'),
                  )
                : Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: TaskList(
                      taskList: filteredTasksList,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
