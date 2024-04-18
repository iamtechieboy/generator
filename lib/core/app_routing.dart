part of 'core.dart';

/// Generate app routing configuration
class AppRoutingClassGenerator {
  static Future<void> generate(projectName) async {
    print("🛠️ Generating app routing...");

    Directory('$projectName/lib/core/routing').createSync(recursive: true);
    final appRoutingDirectory = File('$projectName/lib/core/routing/app_routing.dart');

    appRoutingDirectory.writeAsStringSync("""
// DO NOT DELETE THIS COMMENTED CODE
//::IMPORTS::    
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/features/navigation/presentation/navigation_screen.dart';


class AppRouter {

  // DO NOT DELETE THIS COMMENTED CODE
  //::NAMES::
  static const String examplePageOne = "/examplePageOne";
  static const String examplePageTwo = "/examplePageTwo";

  static final GoRouter router = GoRouter(
    initialLocation: examplePageOne,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => NavigationScreen(
          statefulNavigationShell: navigationShell,
        ),
        branches: [
          /// Navigation section
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: examplePageOne,
                path: examplePageOne,
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
                name: examplePageTwo,
                path: examplePageTwo,
                builder: (context, state) => const Scaffold(
                  body: Text('examplePageTwo'),
                ),
                routes: const <RouteBase>[],
              ),
            ],
          ),
        ],
      ),
      // GoRoute(
      //   name: example,
      //   path: example,
      //   builder: (context, state) => ExampleScreen(),
      // ),
      // Define more routes as needed
      
      // DO NOT DELETE THIS COMMENTED CODE
      //::ROUTES::
     
    ],
  );
}

      """);
    print("Done ✅");
  }
}
