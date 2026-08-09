import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_provider.dart';

class MaintenanceState {
  final bool isMaintenance;
  final String message;

  MaintenanceState({required this.isMaintenance, required this.message});
}

/// Provider that monitors if the app is currently in maintenance mode from Supabase app_settings.
final maintenanceProvider = StateNotifierProvider<MaintenanceNotifier, MaintenanceState>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return MaintenanceNotifier(supabaseClient);
});

class MaintenanceNotifier extends StateNotifier<MaintenanceState> {
  final SupabaseClient _supabase;

  MaintenanceNotifier(this._supabase)
      : super(MaintenanceState(isMaintenance: false, message: '')) {
    checkMaintenance();
  }

  /// Check if the maintenance mode is active from the database
  Future<void> checkMaintenance() async {
    try {
      final response = await _supabase
          .from('app_settings')
          .select('is_maintenance_mode, maintenance_message')
          .limit(1)
          .maybeSingle();

      if (response != null) {
        final isMaintenance = response['is_maintenance_mode'] as bool? ?? false;
        final message = response['maintenance_message'] as String? ?? 
            'Our servers are currently undergoing maintenance. Please check back later.';
        state = MaintenanceState(isMaintenance: isMaintenance, message: message);
      }
    } catch (e) {
      print('Error checking maintenance mode: $e');
    }
  }
}
