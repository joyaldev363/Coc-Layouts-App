import 'package:flutter/material.dart';

class MaintenancePage extends StatelessWidget {
  final String message;
  final VoidCallback onRefresh;

  const MaintenancePage({
    super.key,
    required this.message,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117), // Dark theme matching CoC aesthetics
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Graphic Construction Section
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Base Island/graphic
                    Image.network(
                      'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp',
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                    // Construction/Hammer overlay icon
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Icon(
                        Icons.construction,
                        color: Colors.amber,
                        size: 60,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Text Content
              const Text(
                'System Maintenance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                message.isNotEmpty
                    ? message
                    : 'Our servers are currently undergoing maintenance. Please check back later.',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Refresh / Check Status Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: onRefresh,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.sync, size: 20),
                  label: const Text(
                    'Check Again',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
