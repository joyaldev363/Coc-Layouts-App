import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../models/layout_model.dart';
import '../../../townhall/presentation/pages/layout_detail_page.dart';

class BaseCard extends StatelessWidget {
  final String? title;
  final LayoutModel? layout;

  const BaseCard({super.key, this.title, this.layout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final String displayTitle = layout?.name ?? title ?? 'CoC Layout';
    final String displayImage =
        layout?.imageUrl ??
        'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp';
    final String displayTag = layout?.status ?? 'Published';

    // Generate dynamic mock rating and counts if layout data is empty
    final double rating = layout != null
        ? (4.5 + (layout!.views % 5) * 0.1)
        : 4.8;
    final int viewsCount = layout?.views ?? 12400;
    final int downloadsCount = layout?.downloads ?? 320;

    // Determine Town Hall level text to show in the image badge
    String thDisplay = '';
    if (layout?.thLevel != null && layout!.thLevel.isNotEmpty) {
      final th = layout!.thLevel.toUpperCase();
      if (th.startsWith('TH')) {
        thDisplay = 'Town Hall ${th.substring(2)}';
      } else {
        thDisplay = th;
      }
    } else {
      // Parse TH level from the title (e.g., "TH17 War Base" -> "Town Hall 17")
      final match = RegExp(
        r'TH\s*(\d+)',
        caseSensitive: false,
      ).firstMatch(displayTitle);
      if (match != null) {
        thDisplay = 'Town Hall ${match.group(1)}';
      }
    }

    return GestureDetector(
      onTap: () {
        final targetLayout =
            layout ??
            LayoutModel(
              id: 'dummy',
              name: displayTitle,
              imageUrl: displayImage,
              category: 'War Base',
              type: 'Home',
              thLevel: 'TH17',
              status: displayTag,
              views: viewsCount,
              downloads: downloadsCount,
              tags: ['War'],
              featuredBadges: [],
              createdAt: DateTime.now(),
            );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LayoutDetailPage(layout: targetLayout),
          ),
        );
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(left: 16.0),
        decoration: BoxDecoration(
          color: const Color(
            0xFF111827,
          ), // Deep slate card color matching dark UI
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: CustomNetworkImage(
                    imageUrl: displayImage,
                    height: 137,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // TH level badge container inside the image container
                if (thDisplay.isNotEmpty)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        thDisplay,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    displayTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Rating Stars
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 11,
                          );
                        }),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Stats: Views & Copies
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
