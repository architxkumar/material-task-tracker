import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/widgets/drawer/list_management_dialog.dart';

class ListSelectionDrawerHeader extends StatelessWidget {
  const ListSelectionDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          Text(
            'Lists',
            style: TextTheme.of(context).titleLarge,
          ),
          Text(
            'Manage and switch between your task lists here.',
            style: TextTheme.of(context).bodySmall,
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return ListManagementDialog();
                },
              );
            },
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 0,
            ),
            leading: Icon(Icons.menu),
            title: Text('Manage Lists'),
          ),
        ],
      ),
    );
  }
}

