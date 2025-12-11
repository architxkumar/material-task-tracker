import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/core/ui/overlay_toast.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
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

class DueDateField extends StatefulWidget {
  const DueDateField({super.key});

  @override
  State<DueDateField> createState() => _DueDateFieldState();
}

class _DueDateFieldState extends State<DueDateField> {
  bool _isHoveringOnDueDate = false;

  @override
  Widget build(BuildContext context) {
    final Task task = context.watch<HomeViewModel>().selectedTask!;
    final DateTime? dueDate = task.dueDate;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final Border borderStyle = _isHoveringOnDueDate
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
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.0,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            const Icon(
              Icons.calendar_today,
              size: 16.0,
            ),
            Text(
              'Due Date',
              style: TextTheme.of(context).labelLarge,
            ),
          ],
        ),
        InkWell(
          onHover: (value) => setState(() {
            _isHoveringOnDueDate = !_isHoveringOnDueDate;
          }),
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1, 12, 31),
            );
            if (context.mounted) {
              final result = await context
                  .read<HomeViewModel>()
                  .updatedSelectedTask(
                task.copyWith(dueDate: selectedDate),
              );

              if (context.mounted) {
                if (result.isSuccess()) {
                  showOverlayToast(context, 'Due date updated');
                } else {
                  showOverlayToast(context, 'Failed to update due date');
                }
              }
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              border: borderStyle,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: colorScheme.surfaceContainer,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dueDate != null
                      ? 'Due: ${dueDate.month}/${dueDate.day}/${dueDate.year}'
                      : 'No date set',
                  style: textTheme.bodyMedium?.copyWith(
                    color: dueDate != null ? colorScheme.onSurface : null,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 16.0,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
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

class TimeLabel extends StatefulWidget {
  final String label;
  final DateTime? dateTime;

  const TimeLabel({super.key, required this.label, required this.dateTime});

  @override
  State<TimeLabel> createState() => _TimeLabelState();
}

class _TimeLabelState extends State<TimeLabel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8.0,
      children: [
        const Icon(
          Icons.access_time,
          size: 16.0,
        ),
        Text(
          '${widget.label}: ${widget.dateTime?.month}/${widget.dateTime?.day}/${widget.dateTime?.year} ${widget.dateTime?.hour}:${widget.dateTime?.minute.toString().padLeft(2, '0')}',
          style: TextTheme.of(context).bodyMedium,
        ),
      ],
    );
  }
}
