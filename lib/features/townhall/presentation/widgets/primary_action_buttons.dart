import 'package:flutter/material.dart';

class PrimaryActionButtons extends StatelessWidget {
  const PrimaryActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Text('COPY LAYOUT LINK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              label: const Icon(Icons.file_copy_outlined, size: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 4,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D5DE0), // CoC Blue
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('OPEN IN COC', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  SizedBox(width: 4),
                  CircleAvatar(
                    radius: 9,
                    backgroundImage: NetworkImage('https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp'), // Placeholder Barbarian Icon
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
