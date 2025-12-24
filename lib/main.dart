import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:material_task_tracker/data/repository/tasks_repository.dart';
import 'package:material_task_tracker/data/repository/user_preference_repository.dart';
import 'package:material_task_tracker/data/source/db/database.dart';
import 'package:material_task_tracker/ui/home/home_screen_state_resolver.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final Logger logger = Logger();
  final AppDatabase appDatabase = AppDatabase();
  final SharedPreferencesAsync sharedPreferencesAsync =
      SharedPreferencesAsync();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(
            TaskRepository(appDatabase, logger),
            UserPreferenceRepository(sharedPreferencesAsync, logger),
          ),
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
      home: const HomeScreenStateResolver(),
    );
  }
}
