import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAvatarProvider = StateProvider<String>((ref) {
  return 'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp';
});

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarUrl = ref.watch(userAvatarProvider);

    return Stack(
      children: [
        // Background Image Header
        Container(
          height: 220,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp', // Placeholder for background
              ),
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay for better text visibility
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),
        // Profile Info
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Avatar
              GestureDetector(
                onTap: () => _showAvatarSelector(context, ref, avatarUrl),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.purpleAccent, width: 3),
                        image: DecorationImage(
                          image: NetworkImage(avatarUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // User Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Clash Master',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '#QYJ2CV89',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // League Badge Placeholder
                        const Icon(Icons.shield, color: Colors.deepPurple, size: 28),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Legend League',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.emoji_events, color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '5120',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAvatarSelector(BuildContext context, WidgetRef ref, String currentAvatar) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final avatars = [
      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp', // Barbarian King
      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp', // Archer Queen
      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp', // Grand Warden
      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp', // Royal Champion
      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp', // Hog Rider
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Avatar',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: avatars.map((url) {
                    final isSelected = url == currentAvatar;
                    return GestureDetector(
                      onTap: () {
                        ref.read(userAvatarProvider.notifier).state = url;
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Colors.amber : Colors.transparent,
                            width: 3,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(url),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: isSelected 
                            ? const Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(Icons.check_circle, color: Colors.amber, size: 24),
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
