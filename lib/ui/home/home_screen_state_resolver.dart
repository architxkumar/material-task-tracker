import 'package:flutter/material.dart';
import 'package:material_task_tracker/domain/model/task.dart';
import 'package:material_task_tracker/ui/home/home_content_screen.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/home/state/home_error_screen.dart';
import 'package:material_task_tracker/ui/home/state/home_loading_screen.dart';
import 'package:provider/provider.dart';

/// Observes the state of the Home screen and displays the appropriate UI
class HomeScreenStateResolver extends StatelessWidget {
  const HomeScreenStateResolver({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<List<Task>> taskListStream = context
        .read<HomeViewModel>()
        .taskStream;
    return StreamBuilder(
      stream: taskListStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const HomeLoadingScreen();
        } else if (snapshot.hasError) {
          return const HomeErrorScreen();
        } else {
          return HomeContentScreen(taskList: snapshot.data ?? []);
        }
      },
    );
  }
}
