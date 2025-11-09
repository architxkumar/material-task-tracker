import 'package:flutter/material.dart';
import 'package:material_task_tracker/model/task.dart';
import 'package:result_dart/result_dart.dart';

class TaskDialog extends StatefulWidget {
  final String widgetLabel;
  final String submitButtonLabel;
  final String title;
  final bool isCompleted;
  final Future<Result<bool>> Function(Task) onPressingSaveButton;

  const TaskDialog({
    super.key,
    required this.widgetLabel,
    required this.submitButtonLabel,
    this.title = '',
    this.isCompleted = false,
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
  final TextEditingController _taskTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isCompleted;
    _taskTitleController.text = widget.title;
    _isSubmitButtonEnabled = widget.title.isNotEmpty;
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
                    onPressed: () => (_taskTitleController.text.isNotEmpty)
                        ? _showConfirmationDialog()
                        : {Navigator.pop(context)},
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _taskTitleController,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Add Title',
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
                                body: _taskTitleController.text.trim(),
                                completed: _isCompleted,
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
                                _taskTitleController.clear();
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
