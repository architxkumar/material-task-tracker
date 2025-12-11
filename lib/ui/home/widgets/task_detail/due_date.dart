import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/core/ui/overlay_toast.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class DueDateField extends StatefulWidget {
  const DueDateField({super.key});

  @override
  State<DueDateField> createState() => _DueDateFieldState();
}

class _DueDateFieldState extends State<DueDateField> {
  bool _isHoveringOnDueDate = false;

  void _toggleHoveringOnDueDate(bool isHovering) {
    setState(() {
      _isHoveringOnDueDate = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Task task = context
        .watch<HomeViewModel>()
        .selectedTask!;

    final DateTime? dueDate = task.dueDate;

    final colorScheme = Theme
        .of(context)
        .colorScheme;


    final Border borderStyle = _isHoveringOnDueDate
        ? Border.all(
      color: colorScheme.primary,
      width: 2.0,
    )
        : Border.all(
      color: colorScheme.outlineVariant,
      width: 1.0,
    );

    final BoxDecoration boxDecoration = BoxDecoration(
      border: borderStyle,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      color: colorScheme.surfaceContainer,
    );

    Future<void> onTapContainer() async {
      final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime
            .now()
            .year + 1, 12, 31),
      );
      if (context.mounted) {
        final result = await context.read<HomeViewModel>().updatedSelectedTask(
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
    }

    Future<void> onClearDueDate() async {
      if (context.mounted) {
        final result = await context.read<HomeViewModel>().updatedSelectedTask(
          task.copyWith(dueDate: null),
        );
        if (context.mounted) {
          if (result.isSuccess()) {
            showOverlayToast(context, 'Due date cleared');
          } else {
            showOverlayToast(context, 'Failed to clear due date');
          }
        }
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.0,
      children: [
        const ContainerLabel(label: 'Due Date'),
        InkWell(
          onHover: _toggleHoveringOnDueDate,
          onTap: () async => await onTapContainer(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: boxDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DueDateLabel(dueDate: dueDate),
                if (dueDate != null)
                  ClearTextFieldIconButton(onClearDueDate: onClearDueDate)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContainerLabel extends StatelessWidget {
  final String label;

  const ContainerLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8.0,
      children: [
        const Icon(
          Icons.calendar_today,
          size: 16.0,
        ),
        Text(
          label,
          style: TextTheme
              .of(context)
              .labelLarge,
        ),
      ],
    );
  }
}

class ClearTextFieldIconButton extends StatelessWidget {
  final Future<void> Function() onClearDueDate;

  const ClearTextFieldIconButton({super.key, required this.onClearDueDate});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Clear due date',
      icon: const Icon(Icons.close, size: 16),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: () async => await onClearDueDate(),
    );
  }
}

class DueDateLabel extends StatelessWidget {
  final DateTime? dueDate;

  const DueDateLabel({super.key, this.dueDate});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    return Text(
      dueDate != null
          ? 'Due: ${dueDate!.month}/${dueDate!.day}/${dueDate!.year}'
          : 'No date set',
      style: textTheme.bodyMedium?.copyWith(
        color: dueDate != null ? colorScheme.onSurface : null,
      ),
    );
  }
}

