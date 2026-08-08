import 'package:flutter/material.dart';

class BaseStatsRow extends StatelessWidget {
  const BaseStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                    'War Base',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'TH17',
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
              const Text('4.8', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    '(1.2K)',
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
                    '25.4K',
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
