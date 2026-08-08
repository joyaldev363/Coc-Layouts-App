import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/notification_card.dart';
import '../widgets/notification_filter_chips.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

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
        title: const Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const NotificationFilterChips(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: const [
                NotificationCard(
                  leadingIcon: Icon(Icons.shield, color: Colors.purpleAccent, size: 28),
                  title: 'New TH17 War Base Added!',
                  description: 'A strong new war base for TH17 is now available.',
                  time: '2m ago',
                  trailingImageUrl: 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                  isUnread: true,
                ),
                NotificationCard(
                  leadingIcon: Icon(Icons.emoji_events, color: Colors.amber, size: 28),
                  title: 'Legend League Top Base',
                  description: 'Check out the top performing base in Legend League.',
                  time: '1h ago',
                  trailingImageUrl: 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                  isUnread: true,
                ),
                NotificationCard(
                  leadingIcon: Icon(Icons.download, color: Colors.lightGreen, size: 28),
                  title: 'Download Completed',
                  description: 'TH16 Farming Base has been downloaded successfully.',
                  time: '3h ago',
                ),
                NotificationCard(
                  leadingIcon: Icon(Icons.colorize, color: Colors.redAccent, size: 28),
                  title: 'Clan War League Started',
                  description: 'New Clan War League season has begun!',
                  time: '5h ago',
                ),
                NotificationCard(
                  leadingIcon: Icon(Icons.campaign, color: Colors.blueAccent, size: 28),
                  title: 'Update Available',
                  description: 'A new update is available.\nUpdate now for better experience.',
                  time: '1d ago',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
