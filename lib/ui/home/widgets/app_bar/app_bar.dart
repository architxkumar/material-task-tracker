import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar/filter_button.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar/filter_card.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar/label.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  final List<Task> taskList;

  const HomeAppBar({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    final completedTasks = taskList.where((task) => task.completed).length;
    final pendingTasks = taskList.length - completedTasks;
    final String subtitle = (completedTasks != 0)
        ? '$pendingTasks active · $completedTasks completed'
        : '$pendingTasks active';

    final BoxDecoration containerDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer,
      border: BoxBorder.fromLTRB(
        bottom: BorderSide(color: Theme.of(context).dividerColor),
        left: BorderSide.none,
        right: BorderSide.none,
        top: BorderSide.none,
      ),
    );

    final EdgeInsets containerPadding = const EdgeInsets.only(
      top: 16,
      left: 16,
      right: 16,
      bottom: 16,
    );

    return Container(
      decoration: containerDecoration,
      padding: containerPadding,
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
                    const HomeAppBarFilterButton(),
                  ],
                ),
                if (context
                    .watch<HomeViewModel>()
                    .appBarUiState
                    .isFilterIconActive)
                  const HomeAppBarFilterCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
