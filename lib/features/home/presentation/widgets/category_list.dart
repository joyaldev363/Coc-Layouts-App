import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'War Base', 'icon': Icons.colorize, 'color': Colors.redAccent},
      {'title': 'Farming', 'icon': Icons.eco, 'color': Colors.lightGreen},
      {'title': 'Trophy', 'icon': Icons.emoji_events, 'color': Colors.amber},
      {'title': 'Hybrid', 'icon': Icons.shield, 'color': Colors.purpleAccent},
      {'title': 'Anti 2 Star', 'icon': Icons.security, 'color': Colors.blueAccent},
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final theme = Theme.of(context);
          final colorScheme = theme.colorScheme;
          return Container(
            width: 75,
            margin: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: (cat['color'] as Color).withOpacity(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 32),
                const SizedBox(height: 8),
                Text(
                  cat['title'] as String,
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
