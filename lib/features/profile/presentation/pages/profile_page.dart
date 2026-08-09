import 'package:clashlayouts/features/profile/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/profile_header.dart';

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
            SettingsPage(),
            SizedBox(height: 40), // Bottom padding
          ],
        ),
      ),
    );
  }
}
