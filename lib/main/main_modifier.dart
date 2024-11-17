import 'dart:io';

class MainModifier {
  static Future<void> modifyMain(projectName) async {
    print("♻️ Modifying main.dart...");
    // Path to the main.dart file
    String path = '$projectName/lib/main.dart';

    // Open the file
    File mainDart = File(path);

    // Write your template to the file, replacing its content
    mainDart.writeAsStringSync('''
import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/core/service_locator.dart';
import 'package:$projectName/core/routing/app_routing.dart';
import 'package:$projectName/core/config/app_theme.dart';
import 'package:$projectName/generated/codegen_loader.g.dart';


Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await setupServiceLocator();
      runApp(
        EasyLocalization(
          supportedLocales: const [
            Locale('uz'),
          ],
          path: 'lib/assets/translations',
          fallbackLocale: const Locale('uz'),
          startLocale: const Locale('uz'),
          assetLoader: const CodegenLoader(),
          child: MyApp(),
        ),
      );
    },
    (error, stack) {
      log("Error by runZoneGuarded: ", error: error, stackTrace: stack, level: 10, zone: Zone.current);
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  final GlobalKey _navigatorKey = GlobalKey<NavigatorState>();
  
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaterialApp.router(
        key: _navigatorKey,
        debugShowCheckedModeBanner: false,
        title: '$projectName',
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        theme: AppTheme.theme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
  ''');
  }
}
