import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_detail_page.dart';
import '../widgets/townhall_bottom_panel.dart';
import '../widgets/townhall_grid_item.dart';
import '../widgets/village_toggle.dart';

class TownhallPage extends ConsumerStatefulWidget {
  const TownhallPage({super.key});

  @override
  ConsumerState<TownhallPage> createState() => _TownhallPageState();
}

class _TownhallPageState extends ConsumerState<TownhallPage> {
  bool _isHomeVillage = true;
  int _selectedThIndex =
      16; // TH17 selected by default (index 16 for TH1 to TH17)

  // Dummy data for town halls mimicking the design
  final List<Map<String, dynamic>> _homeTownHalls =
      List.generate(19, (index) {
        final thLevel = index + 1;
        return {
          'level': 'TH$thLevel',
          'imageUrl':
              'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
          'isLocked': thLevel > 18,
        };
      })..add({
        'level': 'Hero Hall',
        'imageUrl':
            'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
        'isLocked': false,
      });

  // Dummy data for builder halls (BH1 to BH10)
  final List<Map<String, dynamic>> _builderHalls = List.generate(10, (index) {
    final bhLevel = index + 1;
    return {
      'level': 'BH$bhLevel',
      'imageUrl':
          'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
      'isLocked': false,
    };
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentList = _isHomeVillage ? _homeTownHalls : _builderHalls;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        title: Text(
          'Town Halls',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          VillageToggle(
            isHomeVillageSelected: _isHomeVillage,
            onHomeSelected: () => setState(() {
              _isHomeVillage = true;
              _selectedThIndex = 16; // Default selection TH17
            }),
            onBuilderSelected: () => setState(() {
              _isHomeVillage = false;
              _selectedThIndex = 8; // Default selection BH9
            }),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.85,
              ),
              itemCount: currentList.length,
              itemBuilder: (context, index) {
                final th = currentList[index];
                return TownhallGridItem(
                  level: th['level'],
                  imageUrl: th['imageUrl'],
                  isSelected: _selectedThIndex == index,
                  isLocked: th['isLocked'],
                  onTap: () {
                    setState(() {
                      _selectedThIndex = index;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            BaseDetailPage(townhallLevel: th['level']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Selected Town Hall Panel at the bottom
          if (_selectedThIndex >= 0 && _selectedThIndex < currentList.length)
            TownhallBottomPanel(
              title: _isHomeVillage
                  ? (currentList[_selectedThIndex]['level'] == 'Hero Hall'
                        ? 'Hero Hall'
                        : 'Town Hall ${currentList[_selectedThIndex]['level'].replaceAll("TH", "")}')
                  : 'Builder Hall ${currentList[_selectedThIndex]['level'].replaceAll("BH", "")}',
              description: _isHomeVillage
                  ? 'The strongest Town Hall with advanced defenses and new features!'
                  : 'The strongest Builder Hall with advanced defense and mechanical marvels!',
              imageUrl: currentList[_selectedThIndex]['imageUrl'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BaseDetailPage(
                      townhallLevel: currentList[_selectedThIndex]['level'],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
