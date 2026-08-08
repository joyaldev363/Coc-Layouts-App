import 'package:flutter/material.dart';

class OfflinePage extends StatelessWidget {
  final VoidCallback onRetry;

  const OfflinePage({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117), // Dark theme
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
        title: const Text(
          'No Internet Connection',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Generally offline screens trap the user until reconnected
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Graphic Section
              Center(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Illustration placeholder
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Image.network(
                        'https://media.oneclash.com/optimized/resized-1780189701875-1600w.webp', // Placeholder base/island
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Wifi Off Symbol overlay
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const Icon(Icons.wifi, color: Colors.grey, size: 120),
                        Positioned(
                          right: 15,
                          bottom: 15,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF0D1117), width: 4),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.close, color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Text Content
              const Text(
                "Oops! You're Offline",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Please check your internet connection\nand try again.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Retry Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.refresh, size: 20),
                  label: const Text(
                    'Retry',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
