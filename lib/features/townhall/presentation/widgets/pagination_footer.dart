import 'package:flutter/material.dart';

class PaginationFooter extends StatelessWidget {
  const PaginationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: colorScheme.background,
        border: Border(top: BorderSide(color: colorScheme.onSurface.withOpacity(0.08))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.onSurface.withOpacity(0.08)),
            ),
            child: IconButton(
              icon: Icon(Icons.chevron_left, color: colorScheme.onSurface.withOpacity(0.5)),
              onPressed: () {},
            ),
          ),
          Text(
            'Showing 1 – 20 of 328',
            style: TextStyle(color: colorScheme.onSurface.withOpacity(0.7), fontSize: 13),
          ),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.onSurface.withOpacity(0.08)),
            ),
            child: IconButton(
              icon: Icon(Icons.chevron_right, color: colorScheme.onSurface),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
