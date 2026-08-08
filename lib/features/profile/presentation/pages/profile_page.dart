import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/profile_header.dart';
import '../widgets/profile_menu.dart';
import '../widgets/profile_stats.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(),
            ProfileStatsRow(),
            ProfileMenu(),
            SizedBox(height: 40), // Bottom padding
          ],
        ),
      ),
    );
  }
}
