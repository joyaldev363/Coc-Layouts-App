import 'package:clashlayouts/features/home/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_detail_page.dart';
import '../widgets/townhall_grid_item.dart';
import '../widgets/village_toggle.dart';

class TownhallPage extends ConsumerStatefulWidget {
  const TownhallPage({super.key});

  @override
  ConsumerState<TownhallPage> createState() => _TownhallPageState();
}

class _TownhallPageState extends ConsumerState<TownhallPage> {
  bool _isHomeVillage = true;
  int _selectedThIndex = 0;

  // Mock fallback data for home village
  final List<Map<String, dynamic>> _mockHomeTownHalls =
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

  // Mock fallback data for builder halls (BH1 to BH10)
  final List<Map<String, dynamic>> _mockBuilderHalls = List.generate(10, (
    index,
  ) {
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
    final townhallsAsync = ref.watch(townhallsProvider);

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
      body: townhallsAsync.when(
        data: (townHalls) {
          // Filter dynamically from Supabase
          final homeList = townHalls
              .where(
                (th) => th.category == 'Home Village' || th.category == 'Both',
              )
              .map(
                (th) => {
                  'level': th.name,
                  'imageUrl': th.imageUrl,
                  'isLocked': false,
                },
              )
              .toList();

          final builderList = townHalls
              .where(
                (th) =>
                    th.category.contains('Builder') || th.category == 'Both',
              )
              .map(
                (th) => {
                  'level': th.name,
                  'imageUrl': th.imageUrl,
                  'isLocked': false,
                },
              )
              .toList();

          // Use fallback mock lists if database is empty
          final currentList = _isHomeVillage
              ? (homeList.isEmpty ? _mockHomeTownHalls : homeList)
              : (builderList.isEmpty ? _mockBuilderHalls : builderList);

          // Reset selected index if it exceeds list range
          if (_selectedThIndex >= currentList.length) {
            _selectedThIndex = 0;
          }

          return Column(
            children: [
              VillageToggle(
                isHomeVillageSelected: _isHomeVillage,
                onHomeSelected: () => setState(() {
                  _isHomeVillage = true;
                  _selectedThIndex = 0;
                }),
                onBuilderSelected: () => setState(() {
                  _isHomeVillage = false;
                  _selectedThIndex = 0;
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
              // if (currentList.isNotEmpty && _selectedThIndex < currentList.length)
              //   TownhallBottomPanel(
              //     title: _isHomeVillage
              //         ? (currentList[_selectedThIndex]['level'] == 'Hero Hall'
              //             ? 'Hero Hall'
              //             : 'Town Hall ${currentList[_selectedThIndex]['level'].replaceAll("TH", "")}')
              //         : 'Builder Hall ${currentList[_selectedThIndex]['level'].replaceAll("BH", "")}',
              //     description: _isHomeVillage
              //         ? 'The strongest Town Hall with advanced defenses and new features!'
              //         : 'The strongest Builder Hall with advanced defense and mechanical marvels!',
              //     imageUrl: currentList[_selectedThIndex]['imageUrl'],
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (_) => BaseDetailPage(
              //             townhallLevel: currentList[_selectedThIndex]['level'],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Column(
          children: [
            VillageToggle(
              isHomeVillageSelected: _isHomeVillage,
              onHomeSelected: () => setState(() {
                _isHomeVillage = true;
                _selectedThIndex = 0;
              }),
              onBuilderSelected: () => setState(() {
                _isHomeVillage = false;
                _selectedThIndex = 0;
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
                itemCount: _isHomeVillage
                    ? _mockHomeTownHalls.length
                    : _mockBuilderHalls.length,
                itemBuilder: (context, index) {
                  final list = _isHomeVillage
                      ? _mockHomeTownHalls
                      : _mockBuilderHalls;
                  final th = list[index];
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
          ],
        ),
      ),
    );
  }
}
