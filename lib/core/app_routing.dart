part of 'core.dart';

/// Generate app routing configuration
class AppRoutingClassGenerator {
  static Future<void> generate(projectName) async {
    print("🛠️ Generating app routing...");

    Directory('$projectName/lib/core/routing').createSync(recursive: true);
    final appRoutingDirectory = File('$projectName/lib/core/routing/app_routing.dart');

    appRoutingDirectory.writeAsStringSync("""
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/features/navigation/presentation/navigation_screen.dart';


class AppRouter {

  static const String home = "/home";
  static const String settings = "/settings";

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => NavigationScreen(
          statefulNavigationShell: navigationShell,
        ),
        branches: [
          /// Main section
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: home,
                path: home,
                builder: (context, state) => const Scaffold(
                  body: Text('Home'),
                ),
                routes: const <RouteBase>[],
              ),
            ],
          ),

          /// Setting section
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: settings,
                path: settings,
                builder: (context, state) => const Scaffold(
                  body: Text('Setting'),
                ),
                routes: const <RouteBase>[],
              ),
            ],
          ),
        ],
      ),
      // GoRoute(
      //   name: home,
      //   path: home,
      //   builder: (context, state) => HomeScreen(),
      // ),
      // Define more routes as needed
    ],
  );
}
      """);
    print("Done ✅");
  }
}
