import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/due_date.dart';
import 'package:material_task_tracker/ui/home/widgets/task_detail/time_labe.dart';
import 'package:provider/provider.dart';

class TaskDetailBodySection extends StatelessWidget {
  const TaskDetailBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DueDateField(),
            const SizedBox(
              height: 24,
            ),
            const DescriptionField(),
            const SizedBox(
              height: 24,
            ),
            const Divider(),
            const SizedBox(
              height: 16,
            ),
            TimeLabel(
              label: 'Created',
              dateTime: context.watch<HomeViewModel>().selectedTask?.createdAt,
            ),
            const SizedBox(
              height: 8,
            ),
            TimeLabel(
              label: 'Last Updated',
              dateTime: context.watch<HomeViewModel>().selectedTask?.updatedAt,
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionField extends StatefulWidget {
  const DescriptionField({super.key});

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  final TextEditingController _controller = TextEditingController();
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
              style: TextTheme.of(context).labelLarge,
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
              buildCounter:
                  (
                    context, {
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
