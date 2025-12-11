import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_task_tracker/ui/core/ui/overlay_toast.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class DescriptionField extends StatefulWidget {
  const DescriptionField({super.key});

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  final TextEditingController _controller = TextEditingController();
  bool _isHovering = false;
  final FocusNode _focusNode = FocusNode();
  String _updatedText = '';

  void _updateTaskDescription() async {
    final selectedTask =
        context
            .read<HomeViewModel>()
            .selectedTask;
    if (_updatedText != selectedTask?.body) {
      final result = await context
          .read<HomeViewModel>()
          .updatedSelectedTask(selectedTask!.copyWith(body: _updatedText));
      if (mounted) {
        if (result.isSuccess()) {
          showOverlayToast(context, 'Description updated');
        } else {
          showOverlayToast(context, 'Failed to update description');
        }
      }
    }
  }


  @override
  void initState() {
    super.initState();
    final selectedTask =
        context
            .read<HomeViewModel>()
            .selectedTask;
    _controller.text = selectedTask?.body ?? '';
    // Updates the task body when text field is no longer focused
    _focusNode.addListener(() async {
      if (!_focusNode.hasFocus) {
        _updateTaskDescription();
      }
    },);
  }


  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    final textTheme = Theme
        .of(context)
        .textTheme;

    final Border borderStyle = _isHovering
        ? Border.all(
      color: colorScheme.primary,
      width: 2.0,
    )
        : Border.all(
      color: colorScheme.outlineVariant,
      width: 1.0,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16.0,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            const Icon(
              Icons.description_outlined,
              size: 16.0,
            ),
            Text(
              'Notes',
              style: TextTheme
                  .of(context)
                  .labelLarge,
            ),
          ],
        ),
        MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: borderStyle,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: colorScheme.surfaceContainer,
            ),
            height: 180,
            width: double.infinity,
            child: TextField(
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                _focusNode.unfocus();
              },
              onTapOutside: (event) => _focusNode.unfocus(),
              onChanged: (value) =>
                  setState(() {
                    _updatedText = value;
                  }),
              focusNode: _focusNode,
              buildCounter:
                  (context, {
                required currentLength,
                required isFocused,
                required maxLength,
              }) => null,
              expands: true,
              maxLength: 2000,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: _controller,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),

              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ),
        ),
        Row(
          children: [
            const Spacer(),
            SelectableText(
              '${_controller.text.length}/2000',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}