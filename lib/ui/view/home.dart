import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/view/widget.dart';
import 'package:material_task_tracker/ui/view_model/home.dart';
import 'package:provider/provider.dart';
import 'package:result_dart/result_dart.dart';

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

class TaskSummaryHeader extends StatelessWidget {
  final int completedTaskCount;
  final int totalTaskCount;

  const TaskSummaryHeader({
    super.key,
    required this.completedTaskCount,
    required this.totalTaskCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Completed $completedTaskCount out of $totalTaskCount tasks',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<Task> taskList;

  const TaskList({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (_) async {
            final result = await context.read<HomeViewModel>().deleteTask(
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
                onPressingSaveButton: context.read<HomeViewModel>().updateTask,
              ),
            ),
            child: TaskListEntry(
              key: ValueKey(taskList[index].completed),
              task: taskList[index],
              onChanged: context.read<HomeViewModel>().updateTask,
            ),
          ),
        ),
      ),
    );
  }
}

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => TaskDialog(
            widgetLabel: 'Add Task',
            submitButtonLabel: 'Save',
            onPressingSaveButton: context.read<HomeViewModel>().insertTask,
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class TaskListEntry extends StatefulWidget {
  final Task task;
  final Future<Result<bool>> Function(Task) onChanged;

  const TaskListEntry({super.key, required this.task, required this.onChanged});

  @override
  State<TaskListEntry> createState() => _TaskListEntryState();
}

class _TaskListEntryState extends State<TaskListEntry> {
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
