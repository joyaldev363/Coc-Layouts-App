import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import 'main_layout.dart';
import '../../features/splash/splash.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Provider for GoRouter to handle application routing.
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splashName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.homeName,
        builder: (context, state) => const MainLayout(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.loginName,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Login Screen'))),
      ),
    ],
    // Implementation of RouteGuard logic can be done here or in a separate controller
    redirect: (BuildContext context, GoRouterState state) {
      // Logic for protected routes goes here
      return null; // Return null if no redirect is needed
    },
  );
});
