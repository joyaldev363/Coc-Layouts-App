import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/base_card.dart';
import '../widgets/category_list.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_banner.dart';
import '../widgets/section_header.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeBanner(),
            const SectionHeader(
              title: 'Latest Bases',
              icon: Text('🔥', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(
              height: 175,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  BaseCard(title: 'TH17 War Base'),
                  BaseCard(title: 'TH16 Farming Base'),
                  BaseCard(title: 'TH15 Trophy Base'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const SectionHeader(
              title: 'Popular Categories',
              icon: SizedBox.shrink(),
            ),
            const CategoryList(),
            const SizedBox(height: 12),
            const SectionHeader(
              title: 'Popular This Week',
              icon: Icon(
                Icons.trending_up,
                color: Colors.purpleAccent,
                size: 24,
              ),
            ),
            SizedBox(
              height: 175,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  BaseCard(title: 'TH17 Legend Base'),
                  BaseCard(title: 'TH16 CWL Base'),
                  BaseCard(title: 'TH14 Hybrid Base'),
                ],
              ),
            ),
            const SizedBox(height: 40), // Bottom padding for scrolling
          ],
        ),
      ),
    );
  }
}
