import 'package:flutter/material.dart';
import 'package:material_task_tracker/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class ListSelectionDrawerListSection extends StatelessWidget {
  const ListSelectionDrawerListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context
          .read<HomeViewModel>()
          .listsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final lists = snapshot.data!;
          return Column(
            children: lists
                .map(
                  (list) =>
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 0,
                    ),
                    leading: const Icon(Icons.list),
                    title: Text(
                      (list.id == 1)
                          ? '${list.title} (Default)'
                          : list.title,
                    ),
                    onTap: () {},
                  ),
            )
                .toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
