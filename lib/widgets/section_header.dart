import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            TextButton(
              onPressed: onSeeAll,
              child: const Text('See All', style: TextStyle(color: AppColors.green)),
            ),
          ],
        ),
      );
}
