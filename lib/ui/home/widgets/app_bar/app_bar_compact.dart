import 'package:flutter/material.dart';

/// A more compact version of the HomeAppBar without a subtitle.
/// Used for loading and error states.
class HomeAppBarCompact extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarCompact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
      child: SafeArea(
        child: Column(
          spacing: 4.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tasks',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(129);
}