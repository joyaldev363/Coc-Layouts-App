import 'package:flutter/material.dart';

class VillageToggle extends StatelessWidget {
  final bool isHomeVillageSelected;
  final VoidCallback onHomeSelected;
  final VoidCallback onBuilderSelected;

  const VillageToggle({
    super.key,
    required this.isHomeVillageSelected,
    required this.onHomeSelected,
    required this.onBuilderSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onHomeSelected,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isHomeVillageSelected ? colorScheme.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isHomeVillageSelected ? Colors.amber : colorScheme.onSurface.withOpacity(0.08),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.home_work, color: Colors.amber, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Home Village',
                      style: TextStyle(
                        color: isHomeVillageSelected ? Colors.amber : colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onBuilderSelected,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: !isHomeVillageSelected ? colorScheme.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: !isHomeVillageSelected ? Colors.amber : colorScheme.onSurface.withOpacity(0.08),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.construction, color: Colors.blueAccent, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Builder Base',
                      style: TextStyle(
                        color: !isHomeVillageSelected ? Colors.amber : colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
