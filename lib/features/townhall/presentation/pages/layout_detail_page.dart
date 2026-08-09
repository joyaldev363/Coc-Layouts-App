import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/models/layout_model.dart';
import '../../../home/providers/home_providers.dart';

import '../widgets/about_base_section.dart';
import '../widgets/base_image_carousel.dart';
import '../widgets/base_stats_row.dart';
import '../widgets/primary_action_buttons.dart';
import '../widgets/recommended_bases_section.dart';

class LayoutDetailPage extends ConsumerWidget {
  final LayoutModel layout;

  const LayoutDetailPage({super.key, required this.layout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (layout.id.isNotEmpty && !layout.id.startsWith('mock_')) {
        ref.read(layoutDetailControllerProvider).incrementViews(layout.id);
      }
    });

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          layout.name.isNotEmpty ? layout.name : 'CoC Layout',
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BaseImageCarousel(
              imageUrl: layout.imageUrl.isNotEmpty
                  ? layout.imageUrl
                  : 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
            ),
            BaseStatsRow(layout: layout),
            AboutBaseSection(layout: layout),
            PrimaryActionButtons(layout: layout),
            const SizedBox(height: 8),
            const RecommendedBasesSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
