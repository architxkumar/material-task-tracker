import 'package:flutter/material.dart';

class TaskCreationFormField extends StatelessWidget {
  final String _label;
  final void Function(String)? _onChanged;
  final TextEditingController _textEditingController;

  const TaskCreationFormField({
    required String label,
    required void Function(String)? onChanged,
    required TextEditingController textEditingController,
    super.key,
  }) : _textEditingController = textEditingController,
       _label = label,
       _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      onChanged: _onChanged,
      decoration: InputDecoration(
        isDense: true,
        hintText: _label,
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
