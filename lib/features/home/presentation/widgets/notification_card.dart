import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_network_image.dart';

class NotificationCard extends StatelessWidget {
  final Widget leadingIcon;
  final String title;
  final String description;
  final String time;
  final String? trailingImageUrl;
  final bool isUnread;

  const NotificationCard({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.description,
    required this.time,
    this.trailingImageUrl,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: leadingIcon,
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isUnread ? Colors.white : Colors.white70,
                    fontSize: 14,
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white30,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Trailing
          if (trailingImageUrl != null)
            Row(
              children: [
                CustomNetworkImage(
                  imageUrl: trailingImageUrl!,
                  width: 70,
                  height: 50,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(8),
                ),
                if (isUnread) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            )
          else
            const Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Icon(Icons.chevron_right, color: Colors.white54),
            ),
        ],
      ),
    );
  }
}
