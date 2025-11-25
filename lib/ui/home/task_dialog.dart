import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:result_dart/result_dart.dart';

class TaskDialog extends StatefulWidget {
  // If task is null, it indicates task creation, else task updation
  final Task? task;
  final String widgetLabel;
  final String submitButtonLabel;
  final Future<Result<bool>> Function(Task) onPressingSaveButton;

  const TaskDialog({
    super.key,
    required this.widgetLabel,
    required this.submitButtonLabel,
    this.task,
    required this.onPressingSaveButton,
  });

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  bool _isCompleted = false;
  bool _isSubmitButtonEnabled = false;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _taskBodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.task?.completed ?? false;
    _titleFieldController.text = widget.task?.title ?? '';
    _taskBodyController.text = widget.task?.body ?? '';
    _isSubmitButtonEnabled = widget.task?.title.isNotEmpty ?? false;
  }

  @override
  void dispose() {
    _titleFieldController.dispose();
    _taskBodyController.dispose();
    super.dispose();
  }

  // FIX: For task updation, if no changes are made, confirmation dialog should not appear
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text('Are you sure you want to discard your changes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close confirmation dialog
              Navigator.pop(context); // Close task creation dialog
            },
            child: const Text('Discard'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    widget.widgetLabel,
                    style: TextTheme.of(context).titleLarge,
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () => (_titleFieldController.text.isNotEmpty)
                        ? _showConfirmationDialog()
                        : {Navigator.pop(context)},
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleFieldController,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Title',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  setState(() {
                    _isSubmitButtonEnabled = value.trim().isNotEmpty;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _taskBodyController,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Body',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Completed'),
                  const Spacer(),
                  Switch(
                    value: _isCompleted,
                    onChanged: (bool value) {
                      setState(() {
                        _isCompleted = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notification_add),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: (_isSubmitButtonEnabled)
                        ? () async {
                            setState(() {
                              _isSubmitButtonEnabled = false;
                              _isLoading = true;
                            });
                            try {
                              final Task task = Task(
                                id: widget.task?.id ?? 0,
                                title: _titleFieldController.text.trim(),
                                body: _taskBodyController.text.trim(),
                                completed: _isCompleted,
                                createdAt:
                                    widget.task?.createdAt ?? DateTime.now(),
                                updatedAt: DateTime.now(),
                                sortOrder: widget.task?.sortOrder ?? 0,
                              );
                              final result = await widget.onPressingSaveButton(
                                task,
                              );
                              if (result.isError() && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Error adding task'),
                                  ),
                                );
                              }
                            } finally {
                              if (context.mounted) {
                                _titleFieldController.clear();
                                setState(() {
                                  _isSubmitButtonEnabled = true;
                                  _isLoading = false;
                                });
                                Navigator.pop(context);
                              }
                            }
                          }
                        : null,
                    child: (_isLoading)
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(widget.submitButtonLabel),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
