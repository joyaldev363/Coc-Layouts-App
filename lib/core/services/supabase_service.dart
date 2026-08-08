import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  Future<void> init() async {
    // Load Supabase credentials from environment variables (built-in dart-define)
    const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
    const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
}
