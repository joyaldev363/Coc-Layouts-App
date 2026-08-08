import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/base_card.dart';
import '../widgets/category_list.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_banner.dart';
import '../widgets/section_header.dart';
import '../widgets/popular_week_card.dart';
import '../widgets/funny_layout_card.dart';
import '../../providers/home_providers.dart';
import '../../models/layout_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutsAsync = ref.watch(layoutsProvider);

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
            layoutsAsync.when(
              data: (layouts) {
                if (layouts.isEmpty) {
                  return _buildMockLatestList();
                }

                final latest = layouts
                    .where(
                      (l) => l.status == 'Published' || l.status == 'Active',
                    )
                    .toList();
                if (latest.isEmpty) return _buildMockLatestList();

                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: latest.length,
                    itemBuilder: (context, index) {
                      return BaseCard(layout: latest[index]);
                    },
                  ),
                );
              },
              loading: () => const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => _buildMockLatestList(),
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
            layoutsAsync.when(
              data: (layouts) {
                if (layouts.isEmpty) {
                  return _buildMockPopularList();
                }

                // Sort by views or downloads
                final popular = List.of(layouts)
                  ..sort((a, b) => b.views.compareTo(a.views));
                final activePopular = popular
                    .where(
                      (l) => l.status == 'Published' || l.status == 'Active',
                    )
                    .toList();

                if (activePopular.isEmpty) return _buildMockPopularList();

                final topThree = activePopular.take(3).toList();

                return Column(
                  children: topThree
                      .map((layout) => PopularWeekCard(layout: layout))
                      .toList(),
                );
              },
              loading: () => const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => _buildMockPopularList(),
            ),
            const SizedBox(height: 12),
            const SectionHeader(
              title: 'Funny Layouts',
              icon: Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.orangeAccent,
                size: 24,
              ),
            ),
            layoutsAsync.when(
              data: (layouts) {
                // Filter layouts with category "funny" or tag "funny"
                final funny = layouts.where((l) {
                  final matchesCat = l.category.toLowerCase().contains('funny');
                  final matchesTags = l.tags.any(
                    (t) => t.toLowerCase().contains('funny'),
                  );
                  final matchesStatus =
                      l.status == 'Published' || l.status == 'Active';
                  return (matchesCat || matchesTags) && matchesStatus;
                }).toList();

                if (funny.isEmpty) {
                  return _buildMockFunnyList();
                }

                final topThree = funny.take(3).toList();
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: topThree.length,
                    itemBuilder: (context, index) {
                      return FunnyLayoutCard(layout: topThree[index]);
                    },
                  ),
                );
              },
              loading: () => const SizedBox(
                height: 120,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => _buildMockFunnyList(),
            ),
            const SizedBox(height: 40), // Bottom padding for scrolling
          ],
        ),
      ),
    );
  }

  Widget _buildMockLatestList() {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          BaseCard(title: 'TH17 War Base'),
          BaseCard(title: 'TH16 Farming Base'),
          BaseCard(title: 'TH15 Trophy Base'),
        ],
      ),
    );
  }

  Widget _buildMockPopularList() {
    final mockLayouts = [
      LayoutModel(
        id: 'mock_pop_1',
        name: 'Anti 3 Star War Base',
        imageUrl:
            'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
        category: 'War Base',
        type: 'Home',
        thLevel: 'TH17',
        status: 'Active',
        views: 15300,
        downloads: 412,
        tags: ['Trending'],
        featuredBadges: [],
        winRate: 4.9,
        description: 'Most copied base of this week',
        createdAt: DateTime.now(),
      ),
      LayoutModel(
        id: 'mock_pop_2',
        name: 'CWL Ring Base',
        imageUrl:
            'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
        category: 'War Base',
        type: 'Home',
        thLevel: 'TH16',
        status: 'Active',
        views: 12400,
        downloads: 380,
        tags: ['Trending'],
        featuredBadges: [],
        winRate: 4.8,
        description: 'Excellent defensive base for CWL',
        createdAt: DateTime.now(),
      ),
      LayoutModel(
        id: 'mock_pop_3',
        name: 'Hybrid Farm Base',
        imageUrl:
            'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
        category: 'Farming',
        type: 'Home',
        thLevel: 'TH15',
        status: 'Active',
        views: 9800,
        downloads: 240,
        tags: ['Trending'],
        featuredBadges: [],
        winRate: 4.7,
        description: 'Optimal dark elixir protection',
        createdAt: DateTime.now(),
      ),
    ];

    return Column(
      children: mockLayouts
          .map((layout) => PopularWeekCard(layout: layout))
          .toList(),
    );
  }

  Widget _buildMockFunnyList() {
    final mockLayouts = [
      LayoutModel(
        id: 'mock_fun_1',
        name: 'Flower Art Layout',
        imageUrl:
            'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
        category: 'Funny',
        type: 'Home',
        thLevel: 'TH16',
        status: 'Active',
        views: 8900,
        downloads: 310,
        tags: ['Funny'],
        featuredBadges: [],
        winRate: 4.8,
        description: 'Beautiful flower layout for decoration',
        createdAt: DateTime.now(),
      ),
      LayoutModel(
        id: 'mock_fun_2',
        name: 'Pikachu Troll Base',
        imageUrl:
            'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
        category: 'Funny',
        type: 'Home',
        thLevel: 'TH15',
        status: 'Active',
        views: 7600,
        downloads: 290,
        tags: ['Funny'],
        featuredBadges: [],
        winRate: 4.7,
        description: 'Pikachu shaped obstacle base design',
        createdAt: DateTime.now(),
      ),
      LayoutModel(
        id: 'mock_fun_3',
        name: 'Heart Shape Progress Base',
        imageUrl:
            'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
        category: 'Funny',
        type: 'Home',
        thLevel: 'TH14',
        status: 'Active',
        views: 6500,
        downloads: 180,
        tags: ['Funny'],
        featuredBadges: [],
        winRate: 4.6,
        description: 'Love heart design layout',
        createdAt: DateTime.now(),
      ),
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: mockLayouts.length,
        itemBuilder: (context, index) {
          return FunnyLayoutCard(layout: mockLayouts[index]);
        },
      ),
    );
  }
}
