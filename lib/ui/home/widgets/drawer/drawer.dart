import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/widgets/drawer/header.dart';
import 'package:material_task_tracker/ui/home/widgets/drawer/list_section.dart';

class ListSelectionDrawer extends StatelessWidget {
  const ListSelectionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const ListSelectionDrawerHeader(),
          const ListSelectionDrawerListSection()
        ],
      ),
    );
  }
}
