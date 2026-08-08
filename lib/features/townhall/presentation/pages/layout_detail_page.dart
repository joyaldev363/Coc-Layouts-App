import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/about_base_section.dart';
import '../widgets/base_image_carousel.dart';
import '../widgets/base_stats_row.dart';
import '../widgets/primary_action_buttons.dart';
import '../widgets/recommended_bases_section.dart';
import '../widgets/secondary_action_buttons.dart';

class LayoutDetailPage extends ConsumerWidget {
  const LayoutDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
          'TH17 Anti 3 Star War Base',
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.redAccent),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            BaseImageCarousel(
              imageUrl:
                  'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
            ),
            BaseStatsRow(),
            AboutBaseSection(),
            PrimaryActionButtons(),
            SecondaryActionButtons(),
            SizedBox(height: 8),
            RecommendedBasesSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
