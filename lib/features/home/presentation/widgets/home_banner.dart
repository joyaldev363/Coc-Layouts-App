import 'dart:async';
import 'package:clashlayouts/features/home/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../models/banner_model.dart';

class HomeBanner extends ConsumerStatefulWidget {
  const HomeBanner({super.key});

  @override
  ConsumerState<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends ConsumerState<HomeBanner> {
  PageController? _pageController;
  Timer? _timer;
  int _currentPage = 0;
  int _lastCount = 0;

  final List<String> _localBanners = [
    'assets/image.png',
    'assets/image copy.png',
  ];

  @override
  void initState() {
    super.initState();
  }

  void _startTimer(int totalPages) {
    _timer?.cancel();
    if (totalPages <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController != null && _pageController!.hasClients) {
        final nextPage = _currentPage + 1;
        _pageController!.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannersAsync = ref.watch(activeBannersProvider);

    return bannersAsync.when(
      data: (banners) {
        final totalCount = banners.isEmpty
            ? _localBanners.length
            : banners.length;

        // Re-initialize PageController and timer if count changes dynamically
        if (_lastCount != totalCount || _pageController == null) {
          _lastCount = totalCount;
          _timer?.cancel();
          _pageController?.dispose();

          _currentPage =
              totalCount * 100; // Large page index multiple of totalCount
          _pageController = PageController(initialPage: _currentPage);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _startTimer(totalCount);
          });
        }

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          height: 180,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount:
                    100000, // Very large index for smooth infinite scroll
                itemBuilder: (context, index) {
                  final actualIndex = index % totalCount;
                  if (banners.isEmpty) {
                    return _buildLocalBannerCard(_localBanners[actualIndex]);
                  } else {
                    return _buildSupabaseBannerCard(banners[actualIndex]);
                  }
                },
              ),
              // Page indicators (Dots)
              Positioned(
                bottom: 12,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(totalCount, (index) {
                    final isSelected = (_currentPage % totalCount) == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3.0),
                      height: 6,
                      width: isSelected ? 16 : 6,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.amber : Colors.white38,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.amber),
        ),
      ),
      error: (err, stack) {
        final totalCount = _localBanners.length;
        if (_lastCount != totalCount || _pageController == null) {
          _lastCount = totalCount;
          _timer?.cancel();
          _pageController?.dispose();

          _currentPage = totalCount * 100;
          _pageController = PageController(initialPage: _currentPage);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _startTimer(totalCount);
          });
        }

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          height: 180,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: 100000,
                itemBuilder: (context, index) {
                  final actualIndex = index % totalCount;
                  return _buildLocalBannerCard(_localBanners[actualIndex]);
                },
              ),
              Positioned(
                bottom: 12,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(totalCount, (index) {
                    final isSelected = (_currentPage % totalCount) == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3.0),
                      height: 6,
                      width: isSelected ? 16 : 6,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.amber : Colors.white38,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocalBannerCard(String assetPath) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF1E293B),
            alignment: Alignment.center,
            child: const Icon(
              Icons.broken_image,
              size: 50,
              color: Colors.white10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupabaseBannerCard(BannerModel banner) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: CustomNetworkImage(
        imageUrl: banner.imageUrl,
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
