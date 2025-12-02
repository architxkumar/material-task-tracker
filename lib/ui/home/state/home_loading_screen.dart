import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/widgets/app_bar/app_bar_compact.dart';

class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBarCompact(),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
