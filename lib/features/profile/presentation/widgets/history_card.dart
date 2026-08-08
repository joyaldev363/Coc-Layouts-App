import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_network_image.dart';

enum HistoryActionType { copied, viewed, downloaded }

class HistoryCard extends StatelessWidget {
  final String thLevel;
  final Color thColor;
  final String title;
  final IconData categoryIcon;
  final Color categoryColor;
  final String categoryName;
  final String time;
  final HistoryActionType actionType;
  final String imageUrl;

  const HistoryCard({
    super.key,
    required this.thLevel,
    this.thColor = Colors.deepPurple,
    required this.title,
    required this.categoryIcon,
    required this.categoryColor,
    required this.categoryName,
    required this.time,
    required this.actionType,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    Color actionColor;
    String actionText;
    IconData actionIcon;

    switch (actionType) {
      case HistoryActionType.copied:
        actionColor = Colors.green;
        actionText = 'Copied Layout';
        actionIcon = Icons.check_circle_outline;
        break;
      case HistoryActionType.viewed:
        actionColor = Colors.lightBlueAccent;
        actionText = 'Viewed';
        actionIcon = Icons.visibility_outlined;
        break;
      case HistoryActionType.downloaded:
        actionColor = Colors.amber; // Design shows yellow for Downloaded
        actionText = 'Downloaded';
        actionIcon = Icons.download_outlined;
        break;
    }

    return Container(
      height: 130, // Fixed height to bound the image
      margin: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // Image
          CustomNetworkImage(
            imageUrl: imageUrl,
            width: 140,
            height: double.infinity,
            fit: BoxFit.cover,
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
          ),
          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: thColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          thLevel,
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.more_vert, color: Colors.white54, size: 18),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          children: [
                            Icon(categoryIcon, color: categoryColor, size: 12),
                            const SizedBox(width: 4),
                            Text(categoryName, style: const TextStyle(color: Colors.white70, fontSize: 10)),
                          ],
                        ),
                      ),
                      Text(time, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(actionIcon, color: actionColor, size: 14),
                          const SizedBox(width: 4),
                          Text(actionText, style: TextStyle(color: actionColor, fontSize: 11)),
                        ],
                      ),
                      Icon(Icons.check_circle, color: actionColor, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
