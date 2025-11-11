import 'package:flutter/material.dart';
import 'package:material_task_tracker/db/database.dart';
import 'package:material_task_tracker/db/tasks_repository.dart';
import 'package:material_task_tracker/model/task.dart';
import 'package:material_task_tracker/ui/widget.dart';
import 'package:result_dart/result_dart.dart';

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
      floatingActionButton: _buildFloatingActionButton(),
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
                      task: taskList[index],
                      onPressingSaveButton: _taskRepository.updateTask,
                    ),
                  ),
                  child: ListEntry(
                    key: ValueKey(taskList[index].completed),
                    task: taskList[index],
                    onChanged: _taskRepository.updateTask,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
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
    );
  }
}

class ListEntry extends StatefulWidget {
  final Task task;
  final Future<Result<bool>> Function(Task) onChanged;
  const ListEntry({super.key, required this.task, required this.onChanged});

  @override
  State<ListEntry> createState() => _ListEntryState();
}

class _ListEntryState extends State<ListEntry> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.completed;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.task.title,
        style: TextStyle(
          decoration: isChecked
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        value: isChecked,
        onChanged: (value) async {
          final result = await widget.onChanged(
            Task(
              id: widget.task.id,
              title: widget.task.title,
              body: widget.task.body,
              completed: value ?? false,
              dueDate: widget.task.dueDate,
              createdAt: widget.task.createdAt,
              updatedAt: DateTime.now(),
              sortOrder: widget.task.sortOrder,
            ),
          );
          if (result.isSuccess()) {
            setState(() {
              isChecked = value ?? false;
            });
          }
        },
      ),
    );
  }
}
