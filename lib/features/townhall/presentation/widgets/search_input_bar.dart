import 'package:flutter/material.dart';

class SearchInputBar extends StatelessWidget {
  const SearchInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.onSurface.withOpacity(0.08)),
      ),
      child: TextField(
        style: TextStyle(color: colorScheme.onSurface),
        decoration: InputDecoration(
          hintText: 'Search by town hall, category or tags...',
          hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.3), fontSize: 13),
          prefixIcon: Icon(Icons.search, color: colorScheme.onSurface.withOpacity(0.5)),
          suffixIcon: IconButton(
            icon: Icon(Icons.cancel, color: colorScheme.onSurface.withOpacity(0.3), size: 20),
            onPressed: () {},
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
