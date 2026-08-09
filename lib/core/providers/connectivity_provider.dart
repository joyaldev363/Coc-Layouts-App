import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/network_info.dart';

/// Provider that monitors if the app is currently offline.
final offlineStateProvider = StateNotifierProvider<OfflineStateNotifier, bool>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  return OfflineStateNotifier(networkInfo);
});

class OfflineStateNotifier extends StateNotifier<bool> {
  final NetworkInfo _networkInfo;
  late final StreamSubscription _subscription;

  OfflineStateNotifier(this._networkInfo) : super(false) {
    _init();
  }

  void _init() async {
    // Initial connection check
    state = !await _networkInfo.isConnected;

    // Listen to connectivity changes
    _subscription = _networkInfo.onConnectivityChanged.listen((results) {
      if (results.contains(ConnectivityResult.none)) {
        state = true;
      } else {
        state = false;
      }
    });
  }

  /// Manually trigger a connection check (e.g. from Retry button)
  Future<void> checkConnection() async {
    state = !await _networkInfo.isConnected;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
