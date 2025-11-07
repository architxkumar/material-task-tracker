import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home.dart';

void main() => runApp(const TaskTrackerApp());

class TaskTrackerApp extends StatelessWidget {
  const TaskTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: 'Material Task Tracker',
      home: const HomeScreen(),
    );
  }
}
