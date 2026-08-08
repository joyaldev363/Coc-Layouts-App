import 'package:flutter/material.dart';
import '../../../home/models/layout_model.dart';

class BaseStatsRow extends StatelessWidget {
  final LayoutModel layout;

  const BaseStatsRow({super.key, required this.layout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Display views in K format if large
    final String displayViews = layout.views >= 1000
        ? '${(layout.views / 1000).toStringAsFixed(1)}K'
        : layout.views.toString();

    // Display rating/win rate
    final String displayRating = layout.winRate != null
        ? layout.winRate!.toStringAsFixed(1)
        : '4.8';

    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.onSurface.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Category
          Row(
            children: [
              const Icon(Icons.shield, color: Colors.redAccent, size: 28),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    layout.category.isNotEmpty ? layout.category : 'War Base',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    layout.thLevel.isNotEmpty ? layout.thLevel : 'TH17',
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Divider
          Container(height: 30, width: 1, color: colorScheme.onSurface.withOpacity(0.08)),
          // Rating
          Column(
            children: [
              Text(displayRating, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    '(${layout.downloads >= 1000 ? "${(layout.downloads / 1000).toStringAsFixed(1)}K" : layout.downloads})',
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Divider
          Container(height: 30, width: 1, color: colorScheme.onSurface.withOpacity(0.08)),
          // Views
          Column(
            children: [
              Row(
                children: [
                  Icon(Icons.visibility, color: colorScheme.onSurface.withOpacity(0.7), size: 16),
                  const SizedBox(width: 4),
                  Text(
                    displayViews,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Views',
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.5),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
