import 'package:flutter/material.dart';
import '../pages/history_page.dart';
import '../pages/settings_page.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.onSurface.withOpacity(0.08)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            _ProfileMenuItem(
              icon: Icons.file_upload_outlined,
              title: 'My Uploads',
              subtitle: 'Bases uploaded by you',
              trailingText: '24',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening My Uploads...')),
                );
              },
            ),
            const _MenuDivider(),
            _ProfileMenuItem(
              icon: Icons.history,
              title: 'History',
              subtitle: 'Your activity',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryPage()),
                );
              },
            ),
            const _MenuDivider(),
            _ProfileMenuItem(
              icon: Icons.star_border,
              title: 'Achievements',
              subtitle: 'Badges and milestones',
              trailingText: '12',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening Achievements...')),
                );
              },
            ),
            const _MenuDivider(),
            _ProfileMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle: 'App preferences',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            const _MenuDivider(),
            _ProfileMenuItem(
              icon: Icons.headset_mic_outlined,
              title: 'Help & Support',
              subtitle: 'Get help and contact us',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening Help & Support...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? trailingText;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(icon, color: colorScheme.onSurface.withOpacity(0.7), size: 28),
      title: Text(
        title,
        style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6), fontSize: 13),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText!,
              style: TextStyle(color: colorScheme.onSurface.withOpacity(0.7), fontSize: 16),
            ),
          if (trailingText != null) const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: colorScheme.onSurface.withOpacity(0.5)),
        ],
      ),
      onTap: onTap,
    );
  }
}

class _MenuDivider extends StatelessWidget {
  const _MenuDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.08),
      indent: 20,
      endIndent: 20,
    );
  }
}
