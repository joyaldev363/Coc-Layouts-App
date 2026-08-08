import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/history_card.dart';
import '../widgets/history_filter_chips.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117), // Dark theme
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('History', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Your activity and downloaded bases', style: TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const HistoryFilterChips(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('Today', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                HistoryCard(
                  thLevel: 'TH17',
                  thColor: Colors.deepPurpleAccent,
                  title: 'Anti 3 Star War Base',
                  categoryIcon: Icons.shield,
                  categoryColor: Colors.redAccent,
                  categoryName: 'War Base',
                  time: '10:30 AM',
                  actionType: HistoryActionType.copied,
                  imageUrl: 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                ),
                HistoryCard(
                  thLevel: 'TH16',
                  thColor: Colors.deepPurple,
                  title: 'Farming Base',
                  categoryIcon: Icons.eco,
                  categoryColor: Colors.lightGreen,
                  categoryName: 'Farming',
                  time: '09:15 AM',
                  actionType: HistoryActionType.viewed,
                  imageUrl: 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                ),
                HistoryCard(
                  thLevel: 'TH15',
                  thColor: Colors.deepPurple,
                  title: 'Hybrid Base',
                  categoryIcon: Icons.shield,
                  categoryColor: Colors.purpleAccent,
                  categoryName: 'Hybrid',
                  time: 'Yesterday',
                  actionType: HistoryActionType.downloaded,
                  imageUrl: 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('This Week', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                HistoryCard(
                  thLevel: 'TH14',
                  thColor: Colors.deepPurple,
                  title: 'Trophy Base',
                  categoryIcon: Icons.emoji_events,
                  categoryColor: Colors.amber,
                  categoryName: 'Trophy',
                  time: '2d ago',
                  actionType: HistoryActionType.copied,
                  imageUrl: 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                ),
                HistoryCard(
                  thLevel: 'TH17',
                  thColor: Colors.deepPurpleAccent,
                  title: 'Ring Base',
                  categoryIcon: Icons.shield,
                  categoryColor: Colors.redAccent,
                  categoryName: 'War Base',
                  time: '3d ago',
                  actionType: HistoryActionType.viewed,
                  imageUrl: 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
