import 'package:clashlayouts/features/home/models/layout_model.dart';
import 'package:clashlayouts/features/home/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/filter_chips_row.dart';
import '../widgets/pagination_footer.dart';
import '../widgets/th_base_list_card.dart';
import '../widgets/th_detail_app_bar.dart';

class BaseDetailPage extends ConsumerStatefulWidget {
  final String townhallLevel;

  const BaseDetailPage({super.key, required this.townhallLevel});

  @override
  ConsumerState<BaseDetailPage> createState() => _BaseDetailPageState();
}

class _BaseDetailPageState extends ConsumerState<BaseDetailPage> {
  String _selectedCategory = 'All';

  late final List<Map<String, String>> _mockBases = [
    {
      'title': '${widget.townhallLevel} Anti 3 Star War Base',
      'category': 'War Base',
      'rating': '4.8',
      'views': '25.4K',
      'likes': '1.2K',
      'imageUrl':
          'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Ring Base War',
      'category': 'War Base',
      'rating': '4.7',
      'views': '18.7K',
      'likes': '982',
      'imageUrl':
          'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Best Farming Base',
      'category': 'Farming',
      'rating': '4.6',
      'views': '14.2K',
      'likes': '780',
      'imageUrl':
          'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Anti Loot Farming',
      'category': 'Farming',
      'rating': '4.5',
      'views': '11.8K',
      'likes': '590',
      'imageUrl':
          'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Trophy Push Base',
      'category': 'Trophy',
      'rating': '4.7',
      'views': '20.1K',
      'likes': '1.1K',
      'imageUrl':
          'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Hybrid Base',
      'category': 'Trophy',
      'rating': '4.6',
      'views': '16.5K',
      'likes': '820',
      'imageUrl':
          'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final layoutsAsync = ref.watch(layoutsProvider);

    String appBarTitle = '${widget.townhallLevel} - All Bases';
    if (_selectedCategory == 'War Base') {
      appBarTitle = '${widget.townhallLevel} - War Bases';
    } else if (_selectedCategory == 'Farming') {
      appBarTitle = '${widget.townhallLevel} - Farming Bases';
    } else if (_selectedCategory == 'Trophy') {
      appBarTitle = '${widget.townhallLevel} - Trophy Bases';
    }

    final isBuilderBase =
        widget.townhallLevel.toLowerCase().contains('bh') ||
        widget.townhallLevel.toLowerCase().contains('builder');

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: ThDetailAppBar(title: appBarTitle),
      body: Column(
        children: [
          if (!isBuilderBase) ...[
            const SizedBox(height: 12),
            FilterChipsRow(
              selectedCategory: _selectedCategory,
              onCategorySelected: (cat) {
                setState(() {
                  _selectedCategory = cat;
                });
              },
            ),
            const SizedBox(height: 16),
          ] else
            const SizedBox(height: 12),
          Expanded(
            child: layoutsAsync.when(
              data: (layouts) {
                // Filter layouts matching this townhallLevel
                final levelLayouts = layouts.where((l) {
                  final String cleanTh = l.thLevel
                      .replaceAll(RegExp(r'[\s-]'), '')
                      .toLowerCase()
                      .replaceAll('builderhall', 'bh')
                      .replaceAll('townhall', 'th');
                  final String cleanWidgetTh = widget.townhallLevel
                      .replaceAll(RegExp(r'[\s-]'), '')
                      .toLowerCase()
                      .replaceAll('builderhall', 'bh')
                      .replaceAll('townhall', 'th');

                  final matchesTh = cleanTh == cleanWidgetTh;
                  final matchesStatus =
                      l.status == 'Published' || l.status == 'Active';
                  return matchesTh && matchesStatus;
                }).toList();

                // Apply category filter
                final filteredLayouts = _selectedCategory == 'All'
                    ? levelLayouts
                    : levelLayouts
                          .where(
                            (l) =>
                                l.category.toLowerCase() ==
                                _selectedCategory.toLowerCase(),
                          )
                          .toList();

                if (filteredLayouts.isEmpty && levelLayouts.isEmpty) {
                  // Fallback to mock data if there are no bases in the database
                  final filteredMocks = _selectedCategory == 'All'
                      ? _mockBases
                      : _mockBases
                            .where((b) => b['category'] == _selectedCategory)
                            .toList();

                  final showPagination = filteredMocks.length > 10;
                  return ListView.builder(
                    itemCount: filteredMocks.length + (showPagination ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (showPagination && index == filteredMocks.length) {
                        return const PaginationFooter();
                      }
                      final base = filteredMocks[index];
                      return ThBaseListCard(
                        layout: LayoutModel(
                          id: 'mock_${index}',
                          name: base['title']!,
                          imageUrl: base['imageUrl']!,
                          category: base['category']!,
                          type: 'Home',
                          thLevel: widget.townhallLevel,
                          status: 'New',
                          views: 25400,
                          downloads: 1200,
                          tags: ['War'],
                          featuredBadges: [],
                          winRate: double.tryParse(base['rating'] ?? '4.8'),
                          createdAt: DateTime.now(),
                        ),
                      );
                    },
                  );
                }

                final showPagination = filteredLayouts.length > 10;
                return ListView.builder(
                  itemCount: filteredLayouts.length + (showPagination ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (showPagination && index == filteredLayouts.length) {
                      return const PaginationFooter();
                    }
                    final base = filteredLayouts[index];
                    return ThBaseListCard(layout: base);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) {
                // Fallback on error
                final filteredMocks = _selectedCategory == 'All'
                    ? _mockBases
                    : _mockBases
                          .where((b) => b['category'] == _selectedCategory)
                          .toList();

                final showPagination = filteredMocks.length > 10;
                return ListView.builder(
                  itemCount: filteredMocks.length + (showPagination ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (showPagination && index == filteredMocks.length) {
                      return const PaginationFooter();
                    }
                    final base = filteredMocks[index];
                    return ThBaseListCard(
                      layout: LayoutModel(
                        id: 'mock_${index}',
                        name: base['title']!,
                        imageUrl: base['imageUrl']!,
                        category: base['category']!,
                        type: 'Home',
                        thLevel: widget.townhallLevel,
                        status: 'New',
                        views: 25400,
                        downloads: 1200,
                        tags: ['War'],
                        featuredBadges: [],
                        winRate: double.tryParse(base['rating'] ?? '4.8'),
                        createdAt: DateTime.now(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
