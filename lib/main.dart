import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:material_task_tracker/data/repository/tasks_repository.dart';
import 'package:material_task_tracker/data/source/db/database.dart';
import 'package:material_task_tracker/ui/home/home_screen.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:material_task_tracker/ui/task_detail/task_detail_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  final Logger logger = Logger();
  final AppDatabase appDatabase = AppDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(TaskRepository(appDatabase, logger)),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              TaskDetailViewModel(TaskRepository(appDatabase, logger)),
        ),
      ],
      child: const TaskTrackerApp(),
    ),
  );
}

class TaskTrackerApp extends StatelessWidget {
  const TaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: 'Material Task Tracker',
      home: const HomeScreen(),
    );
  }
}
