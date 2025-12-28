import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar/filter_card.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar/label.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar/sort_order_card.dart';

class HomeAppBar extends StatefulWidget {
  final List<Task> taskList;
  static const EdgeInsets containerPadding = EdgeInsets.all(
    16.0,
  );

  const HomeAppBar({super.key, required this.taskList});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _isFilterIconSelected = false;

  void _onToggleFilterIcon() {
    setState(() {
      _isFilterIconSelected = !_isFilterIconSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: Keeping them inside build as they are dynamic in nature
    final completedTasks = widget.taskList
        .where((task) => task.completed)
        .length;
    final pendingTasks = widget.taskList.length - completedTasks;
    final String subtitle = (completedTasks != 0)
        ? '$pendingTasks active · $completedTasks completed'
        : '$pendingTasks active';

    return Container(
      decoration: _buildContainerDecoration(),
      padding: HomeAppBar.containerPadding,
      child: SafeArea(
        // Note: It seems that the Center widget is necessary here to make the ConstrainedBox work as expected.
        // The constrained box was being passed tight constraints
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeAppBarLabel(subtitle: subtitle),
                    const Spacer(),
                    IconButton(
                      isSelected: _isFilterIconSelected,
                      icon: const Icon(Icons.tune_sharp),
                      onPressed: _onToggleFilterIcon,
                    ),
                  ],
                ),
                if (_isFilterIconSelected) const HomeAppBarFilterCard(),
                if (_isFilterIconSelected) const SortOrderCard()
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() => BoxDecoration(
    color: Theme.of(context).colorScheme.surfaceContainer,
    border: BoxBorder.fromLTRB(
      bottom: BorderSide(color: Theme.of(context).dividerColor),
      left: BorderSide.none,
      right: BorderSide.none,
      top: BorderSide.none,
    ),
  );
}
