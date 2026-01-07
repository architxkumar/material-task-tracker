import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/core/ui/overlay_toast.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class ListManagementDialog extends StatefulWidget {
  const ListManagementDialog({super.key});

  @override
  State<ListManagementDialog> createState() => _ListManagementDialogState();
}

class _ListManagementDialogState extends State<ListManagementDialog> {
  final _textController = TextEditingController();
  String _newListName = '';

  void _onTextFieldValueChanged(String value) {
    setState(() {
      _newListName = value;
    });
  }

  Future<void> _onSubmitNewList() async {
    final trimmedName = _newListName.trim();
    if (trimmedName.isEmpty) {
      return;
    }
    final result = await context.read<HomeViewModel>().insertList(trimmedName);
    if (mounted) {
      if (result.isSuccess()) {
        showOverlayToast(context, 'List "$trimmedName" created successfully.');
        setState(() {
          _newListName = '';
        });
        _textController.clear();
      } else {
        final errorMessage = result.exceptionOrNull().toString();
        showOverlayToast(context, 'Failed to create list: $errorMessage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = TextTheme.of(context);
    final containerConstraints = const BoxConstraints(
      maxWidth: 600,
      maxHeight: 800,
    );
    final containerDecoration = BoxDecoration(
      border: BoxBorder.all(
        color: colorScheme.outline,
      ),
      color: colorScheme.surfaceVariant,
      borderRadius: BorderRadius.circular(8.0),
    );
    final textFieldDecoration = InputDecoration(
      hintText: 'List Name',
      border: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
    );

    return Dialog(
      child: Container(
        constraints: containerConstraints,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Manage Lists',
                  style: textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Container(
              decoration: containerDecoration,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8.0,
                children: [
                  Text(
                    'Create New List',
                    style: textTheme.labelSmall,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController
                          ,
                          onSubmitted: (_) async => await _onSubmitNewList(),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          onChanged: _onTextFieldValueChanged,
                          decoration: textFieldDecoration,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        key: Key(_newListName),
                        onPressed: _newListName.trim().isEmpty
                            ? null
                            : () async => await _onSubmitNewList(),
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
