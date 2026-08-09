import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../models/layout_model.dart';
import '../../../townhall/presentation/pages/layout_detail_page.dart';

class PopularWeekCard extends StatelessWidget {
  final LayoutModel layout;
  final String tagText;

  const PopularWeekCard({
    super.key,
    required this.layout,
    this.tagText = 'TRENDING',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Use rating if available, else generate a mock rating
    final double rating = layout.rating;
    final String displayViews = layout.views >= 1000
        ? '${(layout.views / 1000).toStringAsFixed(1)}K'
        : layout.views.toString();
    final String displayLikes = layout.downloads >= 1000
        ? '${(layout.downloads / 1000).toStringAsFixed(1)}K'
        : layout.downloads.toString();

    // Dynamically format Town Hall name (e.g. "TH17" -> "TH17 Ring Base")
    String displayTitle = layout.name;
    if (!displayTitle.contains(RegExp(r'th\s*\d+', caseSensitive: false))) {
      displayTitle = '${layout.thLevel.toUpperCase()} $displayTitle';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LayoutDetailPage(layout: layout),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: tagText == 'FUNNY'
                ? Colors.orange.withOpacity(0.4)
                : Colors.purple.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Image + Trending Tag
              Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: layout.imageUrl.isNotEmpty
                        ? layout.imageUrl
                        : 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                    width: 140,
                    height: 145,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: tagText == 'FUNNY' ? Colors.orange : Colors.purple,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tagText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Right Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Bookmark Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              displayTitle,
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.bookmark_border,
                            color: Colors.purpleAccent.withOpacity(0.8),
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Rating Row
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < rating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 13,
                              );
                            }),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: TextStyle(
                              color: colorScheme.onSurface.withOpacity(0.8),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Subtitle
                      Text(
                        layout.description != null &&
                                layout.description!.isNotEmpty
                            ? layout.description!
                            : 'Most copied base of this week',
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.5),
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      // Stats Indicator Row
                      Row(
                        children: [
                          Icon(
                            Icons.visibility_outlined,
                            color: colorScheme.onSurface.withOpacity(0.5),
                            size: 13,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            displayViews,
                            style: TextStyle(
                              color: colorScheme.onSurface.withOpacity(0.7),
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.file_copy_outlined,
                            color: colorScheme.onSurface.withOpacity(0.5),
                            size: 13,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            displayLikes,
                            style: TextStyle(
                              color: colorScheme.onSurface.withOpacity(0.7),
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.greenAccent,
                            size: 13,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '93%',
                            style: TextStyle(
                              color: colorScheme.onSurface.withOpacity(0.7),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Actions buttons Row
                      Row(
                        children: [
                          // Copy Layout button
                          Expanded(
                            child: SizedBox(
                              height: 30,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  final link = layout.copyLink;
                                  if (link != null && link.isNotEmpty) {
                                    Clipboard.setData(
                                      ClipboardData(text: link),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Layout link copied to clipboard!',
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('No copy link found.'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                icon: const Icon(Icons.copy, size: 12),
                                label: const Text(
                                  'Copy Layout',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // View Details button
                          Expanded(
                            child: SizedBox(
                              height: 30,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LayoutDetailPage(layout: layout),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: colorScheme.onSurface,
                                  side: BorderSide(
                                    color: colorScheme.onSurface.withOpacity(
                                      0.12,
                                    ),
                                  ),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'View Details',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Icon(Icons.chevron_right, size: 12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
