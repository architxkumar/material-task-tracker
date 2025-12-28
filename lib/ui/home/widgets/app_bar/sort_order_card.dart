import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:material_task_tracker/domain/model/sort.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class SortOrderCard extends StatelessWidget {
  @Preview(name: 'Sort Order column')
  const SortOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16.0,
      children: [
        const SortOrderCardLabel(),
        SegmentedButton(
          onSelectionChanged: (sortOrder) {
            context.read<HomeViewModel>().onSortOrderSelectionChange(
              sortOrder.first,
            );
          },
          segments: <ButtonSegment<SortMode>>[
            const ButtonSegment(
              value: SortMode.createdAt,
              label: Text('Created date'),
            ),
            const ButtonSegment(
              value: SortMode.dueDate,
              label: Text('Due date'),
            ),
            const ButtonSegment(
              value: SortMode.manual,
              label: Text('Manual order'),
            ),
          ],
          selected: {context.watch<HomeViewModel>().appBarUiState.sortMode},
          showSelectedIcon: true,
          multiSelectionEnabled: false,
        ),
      ],
    );
  }
}

class SortOrderCardLabel extends StatelessWidget {
  const SortOrderCardLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.0,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.swap_vert),
        Text(
          'Sort by',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
