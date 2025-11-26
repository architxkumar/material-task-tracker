import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/widgets/task_creation/action_row.dart';
import 'package:material_task_tracker/ui/home/widgets/task_creation/body.dart';
import 'package:material_task_tracker/ui/home/widgets/task_creation/header.dart';

class TaskCreationModal extends StatefulWidget {
  const TaskCreationModal({super.key});

  @override
  State<TaskCreationModal> createState() => _TaskCreationModalState();
}

class _TaskCreationModalState extends State<TaskCreationModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _bodyFieldController = TextEditingController();

  @override
  void dispose() {
    _titleFieldController.dispose();
    _bodyFieldController.dispose();
    super.dispose(); //
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.0,
          children: [
            TaskCreationModalHeader(
              titleFieldController: _titleFieldController,
            ),
            TaskCreationModalBody(
              taskTitleFieldController: _titleFieldController,
              taskBodyFieldController: _bodyFieldController,
            ),
            const TaskCreationModalActionRow(),
          ],
        ),
      ),
    );
  }
}
