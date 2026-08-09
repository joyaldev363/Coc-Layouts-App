import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'history_page.dart';
import 'legal_page.dart'; // Import the new legal page

// Providers for the settings state
final pushNotificationsProvider = StateProvider<bool>((ref) => true);
final darkThemeProvider = StateProvider<bool>((ref) => true);
final defaultTownHallProvider = StateProvider<String>((ref) => 'TH17');

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkThemeEnabled = ref.watch(darkThemeProvider);

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: [
        _buildSectionHeader(context, 'Preferences'),
        _buildSettingsGroup(context, [
          _buildSwitchItem(
            context,
            Icons.dark_mode_outlined,
            'Dark Theme',
            darkThemeEnabled,
            (val) {
              ref.read(darkThemeProvider.notifier).state = val;
            },
          ),
          _buildDivider(context),
          _buildNavigationItem(
            context,
            Icons.history,
            'History',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryPage()),
              );
            },
          ),
        ]),
        const SizedBox(height: 24),
        _buildSectionHeader(context, 'About'),
        _buildSettingsGroup(context, [
          _buildNavigationItem(
            context,
            Icons.star_outline,
            'Rate Us',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening App Store...')),
              );
            },
          ),

          _buildDivider(context),
          _buildNavigationItem(
            context,
            Icons.privacy_tip_outlined,
            'Privacy Policy',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LegalPage(title: 'Privacy Policy'),
                ),
              );
            },
          ),
          _buildDivider(context),
          _buildNavigationItem(
            context,
            Icons.info_outline,
            'Terms of Service',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LegalPage(title: 'Terms of Service'),
                ),
              );
            },
          ),
          _buildDivider(context),
          _buildVersionItem(context),
        ]),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: colorScheme.onBackground.withOpacity(0.5),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, List<Widget> children) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.onSurface.withOpacity(0.08)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(children: children),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 1,
      color: colorScheme.onSurface.withOpacity(0.08),
      margin: const EdgeInsets.only(left: 56.0, right: 16.0),
    );
  }

  Widget _buildSwitchItem(
    BuildContext context,
    IconData icon,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.onSurface.withOpacity(0.7), size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.amber,
            activeTrackColor: Colors.amber.withOpacity(0.3),
            inactiveThumbColor: colorScheme.onSurface.withOpacity(0.4),
            inactiveTrackColor: colorScheme.onSurface.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionItem(
    BuildContext context,
    WidgetRef ref,
    IconData icon,
    String title,
    String selectedValue,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => _showTownHallSelector(context, ref, selectedValue),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.onSurface.withOpacity(0.7), size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              selectedValue,
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurface.withOpacity(0.3),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showTownHallSelector(
    BuildContext context,
    WidgetRef ref,
    String currentValue,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select Default Town Hall',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  color: colorScheme.onSurface.withOpacity(0.08),
                  height: 1,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 17,
                    itemBuilder: (context, index) {
                      final thLevel = 'TH${17 - index}';
                      final isSelected = thLevel == currentValue;

                      return ListTile(
                        title: Text(
                          thLevel,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.amber
                                : colorScheme.onSurface,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.amber)
                            : null,
                        onTap: () {
                          ref.read(defaultTownHallProvider.notifier).state =
                              thLevel;
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive
                  ? Colors.redAccent
                  : colorScheme.onSurface.withOpacity(0.7),
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isDestructive
                      ? Colors.redAccent
                      : colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (!isDestructive)
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurface.withOpacity(0.3),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionItem(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Clash Layouts is up to date!')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: colorScheme.onSurface.withOpacity(0.7),
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'App Version',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              'v1.0.0',
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
