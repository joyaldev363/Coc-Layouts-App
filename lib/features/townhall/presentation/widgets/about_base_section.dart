import 'package:flutter/material.dart';

class AboutBaseSection extends StatelessWidget {
  const AboutBaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.onSurface.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About This Base',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Powerful anti 3 star war base for Town Hall 17.\nWorks great in CWL and regular wars.',
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.7),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: const [
                Text('Read More ', style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
                Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent, size: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}
