import 'package:flutter/material.dart';
import 'package:material_task_tracker/db/database.dart';
import 'package:material_task_tracker/db/tasks_repository.dart';
import 'package:material_task_tracker/model/task.dart';
import 'package:material_task_tracker/ui/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskRepository _taskRepository = TaskRepository(AppDatabase());
  late final _taskList = _taskRepository.getTasksList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TaskDialog(
              widgetLabel: 'Add Task',
              submitButtonLabel: 'Save',
              onPressingSaveButton: _taskRepository.insertTask,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Material Task Tracker'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _taskList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else {
            final List<Task> taskList = snapshot.data ?? [];
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) => Dismissible(
                onDismissed: (_) async {
                  final result = await _taskRepository.deleteTask(
                    taskList[index],
                  );
                  if (context.mounted) {
                    if (result.isSuccess()) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text('Task deleted'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to delete task'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  }
                },
                key: ValueKey(taskList[index].id),
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => TaskDialog(
                      widgetLabel: 'Update Task',
                      submitButtonLabel: 'Update',
                      title: taskList[index].title,
                      isCompleted: taskList[index].completed ?? false,
                      onPressingSaveButton: _taskRepository.updateTask,
                    ),
                  ),
                  child: ListTile(
                    title: Text(taskList[index].title),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
