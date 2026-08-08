import 'package:clashlayouts/features/home/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildDefaultCategories(context);
  }

  Widget _buildDefaultCategories(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final categories = [
      {
        'title': 'Heroes',
        'count': '4',
        'imageUrl':
            'https://static.wikia.nocookie.net/clashofclans/images/4/4c/Barbarian_King_render.png',
        'color': Colors.purpleAccent,
      },
      {
        'title': 'Troops',
        'count': '35',
        'imageUrl':
            'https://static.wikia.nocookie.net/clashofclans/images/8/87/Archer_render.png',
        'color': Colors.greenAccent,
      },
      {
        'title': 'Pets',
        'count': '10',
        'imageUrl':
            'https://static.wikia.nocookie.net/clashofclans/images/6/6c/L.A.S.S.I._render.png',
        'color': Colors.blueAccent,
      },
      {
        'title': 'Spells',
        'count': '11',
        'imageUrl':
            'https://static.wikia.nocookie.net/clashofclans/images/0/07/Healing_Spell.png',
        'color': Colors.orangeAccent,
      },
      {
        'title': 'Siege Machines',
        'count': '5',
        'imageUrl':
            'https://static.wikia.nocookie.net/clashofclans/images/4/4e/Wall_Wrecker.png',
        'color': Colors.redAccent,
      },
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final accentColor = cat['color'] as Color;

          return Container(
            width: 190,
            margin: const EdgeInsets.only(right: 12.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: index == 0
                    ? Colors.purple.withOpacity(0.5)
                    : colorScheme.onSurface.withOpacity(0.08),
                width: index == 0 ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              children: [
                // Left Image
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network(
                    cat['imageUrl'] as String,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.shield_outlined,
                      color: accentColor,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Center Title + Count Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cat['title'] as String,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        cat['count'] as String,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        'Categories',
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.4),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                // Right Arrow Action Button
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? Colors.purple.withOpacity(0.2)
                        : colorScheme.onSurface.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: index == 0
                        ? Colors.purpleAccent
                        : colorScheme.onSurface.withOpacity(0.6),
                    size: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
