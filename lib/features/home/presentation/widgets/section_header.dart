import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color? actionColor;
  final VoidCallback? onSeeAllTap;
  final bool showSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    required this.icon,
    this.actionColor,
    this.onSeeAllTap,
    this.showSeeAll = true,
  });

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
          if (showSeeAll)
            InkWell(
              onTap: onSeeAllTap ?? () {},
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(
                      color: actionColor ?? colorScheme.onBackground.withOpacity(0.7),
                      fontSize: 13,
                      fontWeight: actionColor != null ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: actionColor ?? colorScheme.onBackground.withOpacity(0.7),
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

