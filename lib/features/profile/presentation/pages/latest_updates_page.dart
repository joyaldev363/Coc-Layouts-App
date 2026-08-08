import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LatestUpdatesPage extends ConsumerWidget {
  const LatestUpdatesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latest Updates')),
      body: const Center(child: Text('Latest Updates Page Content')),
    );
  }
}
