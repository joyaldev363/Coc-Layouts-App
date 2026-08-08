import 'package:flutter/material.dart';

class TownhallGridItem extends StatelessWidget {
  final String level;
  final String imageUrl;
  final bool isSelected;
  final bool isLocked;
  final VoidCallback onTap;

  const TownhallGridItem({
    super.key,
    required this.level,
    required this.imageUrl,
    required this.isSelected,
    this.isLocked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.amber : colorScheme.onSurface.withOpacity(0.08),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: isLocked ? 0.3 : 1.0,
                  child: Image.network(
                    imageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.account_balance, color: colorScheme.onSurface.withOpacity(0.4), size: 40),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  level,
                  style: TextStyle(
                    color: isLocked ? colorScheme.onSurface.withOpacity(0.3) : colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            if (isLocked)
              Icon(Icons.lock, color: colorScheme.onSurface.withOpacity(0.7), size: 24),
          ],
        ),
      ),
    );
  }
}
