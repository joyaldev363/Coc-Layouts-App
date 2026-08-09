import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/home_providers.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // Home Village Card
          Expanded(
            child: _CategoryCard(
              title: 'Home Village',
              count: '128',
              icon: Icons.security_rounded,
              iconColor: const Color(0xFF8B5CF6),
              themeColor: const Color(0xFF8B5CF6),
              gradientColors: const [
                Color(0xFFF3E8FF),
                Color(0xFFFAF5FF),
              ],
              imageUrl: 'https://static.wikia.nocookie.net/clashofclans/images/c/c0/Town_Hall16.png',
              onTap: () {
                ref.read(selectedVillageTypeProvider.notifier).state = true;
                ref.read(currentTabProvider.notifier).state = 1; // Switch to Town Halls tab
              },
            ),
          ),
          const SizedBox(width: 16),
          // Builder Base Card
          Expanded(
            child: _CategoryCard(
              title: 'Builder Base',
              count: '96',
              icon: Icons.gavel_rounded,
              iconColor: const Color(0xFF10B981),
              themeColor: const Color(0xFF10B981),
              gradientColors: const [
                Color(0xFFE6F9F5),
                Color(0xFFF0FDF4),
              ],
              imageUrl: 'https://static.wikia.nocookie.net/clashofclans/images/8/87/Builder_Hall10.png',
              onTap: () {
                ref.read(selectedVillageTypeProvider.notifier).state = false;
                ref.read(currentTabProvider.notifier).state = 1; // Switch to Town Halls tab
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color iconColor;
  final Color themeColor;
  final List<Color> gradientColors;
  final String imageUrl;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.iconColor,
    required this.themeColor,
    required this.gradientColors,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Adjust gradients for dark mode if active
    final effectiveGradientColors = isDark
        ? [
            widget.gradientColors[0].withOpacity(0.15),
            widget.gradientColors[1].withOpacity(0.05),
          ]
        : widget.gradientColors;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: effectiveGradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? widget.themeColor.withOpacity(0.4)
                  : (isDark ? Colors.white10 : Colors.black.withOpacity(0.03)),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.themeColor.withOpacity(_isHovered ? 0.12 : 0.04),
                blurRadius: _isHovered ? 16 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // 3D Render Image (Town Hall / Builder Hall) positioned on the right
                Positioned(
                  right: -10,
                  top: 10,
                  bottom: 25,
                  width: 110,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      widget.icon,
                      color: widget.themeColor.withOpacity(0.15),
                      size: 80,
                    ),
                  ),
                ),
                // Top-Left Icon Container
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.iconColor,
                      size: 24,
                    ),
                  ),
                ),
                // Bottom Content
                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : const Color(0xFF1E1E3F),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${widget.count} ',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: widget.themeColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Layouts',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isDark ? Colors.grey[400] : const Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Arrow Action Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: widget.themeColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: widget.themeColor.withOpacity(0.4),
                              blurRadius: _isHovered ? 8 : 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
