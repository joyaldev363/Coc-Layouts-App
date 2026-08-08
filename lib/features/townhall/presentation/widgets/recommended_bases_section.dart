import 'package:flutter/material.dart';

class RecommendedBasesSection extends StatelessWidget {
  const RecommendedBasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended Bases',
                style: TextStyle(color: colorScheme.onBackground, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Row(
                children: const [
                  Text('View All ', style: TextStyle(color: Colors.blueAccent, fontSize: 12)),
                  Icon(Icons.chevron_right, color: Colors.blueAccent, size: 16),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.onSurface.withOpacity(0.08)),
                  image: const DecorationImage(
                    image: NetworkImage('https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp'), // Placeholder base image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_border, color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
