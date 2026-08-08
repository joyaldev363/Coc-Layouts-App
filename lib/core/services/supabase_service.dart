import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  Future<void> init() async {
    // Load Supabase credentials from environment variables (built-in dart-define) with fallback defaults
    const supabaseUrl = String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: 'https://diuobqbczdfxekpopfwp.supabase.co',
    );
    const supabaseAnonKey = String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: 'sb_publishable_fFZ5X_H4-PcCbVFtIAHOEA_VZPBZHUE',
    );

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
}
