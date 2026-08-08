import 'package:flutter/material.dart';

class RecentSearchesSection extends StatelessWidget {
  const RecentSearchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final searches = ['th17 war', 'th16 farming', 'anti 3 star', 'th15'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: TextStyle(
                  color: colorScheme.onBackground,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Clear', style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
              )
            ],
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: searches.map((s) => _buildChip(context, s)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.onBackground.withOpacity(0.12)),
      ),
      child: Text(
        label,
        style: TextStyle(color: colorScheme.onBackground.withOpacity(0.7), fontSize: 12),
      ),
    );
  }
}
