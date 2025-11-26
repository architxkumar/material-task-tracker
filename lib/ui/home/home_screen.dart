import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/task_creation/button.dart';
import 'package:material_task_tracker/ui/home/widgets/task_list/list.dart';
import 'package:material_task_tracker/ui/home/widgets/task_list/summary_header.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<List<Task>> taskListStream = context
        .read<HomeViewModel>()
        .taskStream;
    return Scaffold(
      floatingActionButton: const AddTaskButton(),
      appBar: AppBar(
        title: const Text('Material Task Tracker'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: taskListStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else {
            final List<Task> taskList = snapshot.data ?? [];
            final int totalTaskCount = taskList.length;
            final int completedTaskCount = taskList
                .where((element) => element.completed == true)
                .length;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskSummaryHeader(
                  completedTaskCount: completedTaskCount,
                  totalTaskCount: totalTaskCount,
                ),
                (taskList.isEmpty)
                    ? const Expanded(
                        child: Center(
                          child: Text('No tasks found'),
                        ),
                      )
                    : TaskList(taskList: taskList),
              ],
            );
          }
        },
      ),
    );
  }
}
