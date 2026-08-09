import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/models/layout_model.dart';
import '../../../home/providers/home_providers.dart';

class PrimaryActionButtons extends ConsumerWidget {
  final LayoutModel layout;

  const PrimaryActionButtons({super.key, required this.layout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        children: [
          // OPEN IN COC
          Expanded(
            flex: 5,
            child: ElevatedButton(
              onPressed: () {
                final link = layout.copyLink;
                if (link != null && link.isNotEmpty) {
                  Clipboard.setData(ClipboardData(text: link));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Copied link: $link'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  if (layout.id.isNotEmpty && !layout.id.startsWith('mock_')) {
                    ref.read(layoutDetailControllerProvider).incrementDownloads(layout.id);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No link found to open.'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D5DE0), // CoC Blue
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'OPEN IN COC',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                  SizedBox(width: 4),
                  CircleAvatar(
                    radius: 8,
                    backgroundImage: NetworkImage(
                      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // SHARE
          Expanded(
            flex: 4,
            child: OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSurface,
                side: BorderSide(color: colorScheme.onSurface.withOpacity(0.08)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: colorScheme.surface,
              ),
              icon: const Icon(Icons.share, size: 14),
              label: const Text(
                'SHARE',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // DOWNLOAD
          Expanded(
            flex: 4,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Starting layout image download...'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                if (layout.id.isNotEmpty && !layout.id.startsWith('mock_')) {
                  ref.read(layoutDetailControllerProvider).incrementDownloads(layout.id);
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSurface,
                side: BorderSide(color: colorScheme.onSurface.withOpacity(0.08)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: colorScheme.surface,
              ),
              icon: const Icon(Icons.download, size: 14),
              label: const Text(
                'DOWNLOAD',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

