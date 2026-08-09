import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/offline_page.dart';
import 'core/providers/connectivity_provider.dart';
import 'core/providers/maintenance_provider.dart';
import 'core/widgets/maintenance_page.dart';
import 'core/routes/app_router.dart';
import 'core/services/shared_pref_service.dart';
import 'core/services/storage_service.dart';
import 'core/services/supabase_service.dart'; // Import Supabase
import 'core/theme/app_theme.dart';
import 'features/profile/presentation/pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize Hive Storage
  final storageService = StorageService();
  await storageService.init();

  // Initialize Supabase Service
  final supabaseService = SupabaseService();
  await supabaseService.init();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefServiceProvider.overrideWithValue(
          SharedPrefService(sharedPreferences),
        ),
        storageServiceProvider.overrideWithValue(storageService),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final isDarkMode = ref.watch(darkThemeProvider);
    final isOffline = ref.watch(offlineStateProvider);
    final maintenanceState = ref.watch(maintenanceProvider);

    return MaterialApp.router(
      title: 'Clash Layouts',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: goRouter,
      builder: (context, child) {
        if (isOffline) {
          return OfflinePage(
            onRetry: () {
              ref.read(offlineStateProvider.notifier).checkConnection();
            },
          );
        }
        if (maintenanceState.isMaintenance) {
          return MaintenancePage(
            message: maintenanceState.message,
            onRefresh: () {
              ref.read(maintenanceProvider.notifier).checkMaintenance();
            },
          );
        }
        return child ?? const SizedBox();
      },
    );
  }
}
