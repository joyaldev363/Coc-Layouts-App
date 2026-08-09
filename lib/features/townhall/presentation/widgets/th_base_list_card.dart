import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../home/models/layout_model.dart';
import '../pages/layout_detail_page.dart';

class ThBaseListCard extends StatelessWidget {
  final LayoutModel layout;

  const ThBaseListCard({super.key, required this.layout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final String displayRating = layout.rating.toStringAsFixed(1);

    final String displayViews = layout.views >= 1000
        ? '${(layout.views / 1000).toStringAsFixed(1)}K'
        : layout.views.toString();

    final String displayLikes = layout.downloads >= 1000
        ? '${(layout.downloads / 1000).toStringAsFixed(1)}K'
        : layout.downloads.toString();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LayoutDetailPage(layout: layout)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.onSurface.withOpacity(0.08)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Left
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                  child: CustomNetworkImage(
                    imageUrl: layout.imageUrl.isNotEmpty
                        ? layout.imageUrl
                        : 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                    width: 150,
                    height: 155, // Adjust height to match content
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            // Details Right
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
                        Expanded(
                          child: Text(
                            layout.name,
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.shield,
                              color: Colors.redAccent,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              layout.category.isNotEmpty
                                  ? layout.category
                                  : 'War Base',
                              style: TextStyle(
                                color: colorScheme.onSurface.withOpacity(0.7),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              displayRating,
                              style: TextStyle(
                                color: colorScheme.onSurface.withOpacity(0.7),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          color: colorScheme.onSurface.withOpacity(0.5),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          displayViews,
                          style: TextStyle(
                            color: colorScheme.onSurface.withOpacity(0.7),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          displayLikes,
                          style: TextStyle(
                            color: colorScheme.onSurface.withOpacity(0.7),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final link = layout.copyLink;
                          if (link != null && link.isNotEmpty) {
                            Clipboard.setData(ClipboardData(text: link));
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
                                content: Text(
                                  'Copy link not available for this layout.',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        icon: const Text(
                          'COPY LINK',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        label: const Icon(Icons.file_copy_outlined, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
