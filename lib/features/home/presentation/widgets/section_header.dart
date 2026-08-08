import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget icon;

  const SectionHeader({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              if (icon is! SizedBox) const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: colorScheme.onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  'See All',
                  style: TextStyle(
                    color: colorScheme.onBackground.withOpacity(0.7),
                    fontSize: 13,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onBackground.withOpacity(0.7),
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
