import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class TaskCreationField extends StatefulWidget {
  const TaskCreationField({super.key});

  @override
  State<TaskCreationField> createState() => _TaskCreationFieldState();
}

class _TaskCreationFieldState extends State<TaskCreationField> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _titleFieldFocusNode = FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    _titleFieldFocusNode.dispose();
    super.dispose();
  }

  String? _validateForm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (value.trim().isEmpty) {
      return 'Please enter valid text';
    }
    return null;
  }

  void _onFormSubmitted() async {
    if (_formKey.currentState!.validate()) {
      // Validation ensures that the value being retrieved isn't whitespace
      final String inputValue = _controller.text.trim();
      _controller.clear();
      _titleFieldFocusNode.unfocus();
      final result = await context.read<HomeViewModel>().insertTask(inputValue);
      if (mounted) {
        if (result.isSuccess()) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(_buildSnackbar('Task created successfully'));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(_buildSnackbar('Error saving task'));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4.0,
          children: [
            IconButton(
              onPressed: _onFormSubmitted,
              icon: const Icon(
                Icons.add_circle_outlined,
                size: 48,
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  focusNode: _titleFieldFocusNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _onFormSubmitted(),
                  controller: _controller,
                  validator: _validateForm,
                  decoration: _buildInputFieldDecoration(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputFieldDecoration() => const InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    hintText: 'Add a new task',
  );

  SnackBar _buildSnackbar(String value) => SnackBar(
    content: Text(value),
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
  );
}
