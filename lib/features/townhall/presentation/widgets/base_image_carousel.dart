import 'package:flutter/material.dart';

class BaseImageCarousel extends StatelessWidget {
  final String imageUrl;

  const BaseImageCarousel({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image
        Image.network(
          imageUrl,
          width: double.infinity,
          height: 320,
          fit: BoxFit.cover,
        ),
        // Dots indicator placeholder
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDot(true),
              _buildDot(false),
              _buildDot(false),
              _buildDot(false),
              _buildDot(false),
            ],
          ),
        ),
        // Fullscreen Icon
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.fullscreen, color: Colors.white, size: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 8 : 6,
      height: isActive ? 8 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.amber : Colors.white54,
        shape: BoxShape.circle,
      ),
    );
  }
}
