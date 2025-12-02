import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeAppBarFilterButton extends StatelessWidget {
  const HomeAppBarFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      isSelected: context.watch<HomeViewModel>().appBarUiState.isFilterIconActive,
      icon: const Icon(Icons.tune_sharp),
      onPressed: context.read<HomeViewModel>().onFilterIconPressed,
    );
  }
}
