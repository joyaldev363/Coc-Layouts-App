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

  late final List<Map<String, String>> _allBases = [
    {
      'title': '${widget.townhallLevel} Anti 3 Star War Base',
      'category': 'War Base',
      'rating': '4.8',
      'views': '25.4K',
      'likes': '1.2K',
      'imageUrl': 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Ring Base War',
      'category': 'War Base',
      'rating': '4.7',
      'views': '18.7K',
      'likes': '982',
      'imageUrl': 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Best Farming Base',
      'category': 'Farming',
      'rating': '4.6',
      'views': '14.2K',
      'likes': '780',
      'imageUrl': 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Anti Loot Farming',
      'category': 'Farming',
      'rating': '4.5',
      'views': '11.8K',
      'likes': '590',
      'imageUrl': 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Trophy Push Base',
      'category': 'Trophy',
      'rating': '4.7',
      'views': '20.1K',
      'likes': '1.1K',
      'imageUrl': 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
    {
      'title': '${widget.townhallLevel} Hybrid Base',
      'category': 'Trophy',
      'rating': '4.6',
      'views': '16.5K',
      'likes': '820',
      'imageUrl': 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBases = _selectedCategory == 'All'
        ? _allBases
        : _allBases.where((b) => b['category'] == _selectedCategory).toList();

    String appBarTitle = '${widget.townhallLevel} - All Bases';
    if (_selectedCategory == 'War Base') {
      appBarTitle = '${widget.townhallLevel} - War Bases';
    } else if (_selectedCategory == 'Farming') {
      appBarTitle = '${widget.townhallLevel} - Farming Bases';
    } else if (_selectedCategory == 'Trophy') {
      appBarTitle = '${widget.townhallLevel} - Trophy Bases';
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: ThDetailAppBar(title: appBarTitle),
      body: Column(
        children: [
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
          Expanded(
            child: ListView.builder(
              itemCount: filteredBases.length + 1,
              itemBuilder: (context, index) {
                if (index == filteredBases.length) {
                  return const PaginationFooter();
                }
                final base = filteredBases[index];
                return ThBaseListCard(
                  title: base['title']!,
                  category: base['category']!,
                  rating: base['rating']!,
                  views: base['views']!,
                  likes: base['likes']!,
                  imageUrl: base['imageUrl']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
