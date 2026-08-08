import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/recent_searches_section.dart';
import '../widgets/search_input_bar.dart';
import '../widgets/search_result_card.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

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
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: Text(
          'Search Bases',
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: colorScheme.onBackground),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchInputBar(),
          const RecentSearchesSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              'Results (128)',
              style: TextStyle(
                color: colorScheme.onBackground.withOpacity(0.7),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                SearchResultCard(
                  title: 'TH17 Anti 3 Star War Base',
                  category: 'War Base',
                  rating: '4.8',
                  views: '25.4K',
                  likes: '1.2K',
                  imageUrl:
                      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                ),
                SearchResultCard(
                  title: 'TH17 Ring Base War',
                  category: 'War Base',
                  rating: '4.7',
                  views: '18.7K',
                  likes: '982',
                  imageUrl:
                      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                ),
                SearchResultCard(
                  title: 'TH17 Box Base Anti 2 Star',
                  category: 'Anti 2 Star',
                  rating: '4.6',
                  views: '15.9K',
                  likes: '842',
                  imageUrl:
                      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                  categoryIcon: Icons.eco,
                  categoryColor: Colors.lightGreen,
                ),
                SearchResultCard(
                  title: 'TH17 Farming Base',
                  category: 'Farming Base',
                  rating: '4.6',
                  views: '12.1K',
                  likes: '621',
                  imageUrl:
                      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                  categoryIcon: Icons.eco,
                  categoryColor: Colors.lightGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
