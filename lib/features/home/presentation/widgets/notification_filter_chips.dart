import 'package:flutter/material.dart';

class NotificationFilterChips extends StatelessWidget {
  final List<String> filters = const ['All', 'Updates', 'Events', 'System'];
  final int selectedIndex = 0;

  const NotificationFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Container(
            margin: const EdgeInsets.only(right: 12.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.amber : const Color(0xFF161B22),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Colors.amber : Colors.white10,
              ),
            ),
            child: Center(
              child: Text(
                filters[index],
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
