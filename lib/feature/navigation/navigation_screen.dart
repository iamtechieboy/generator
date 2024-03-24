import 'dart:io';

class NavigationScreenGenerator {
  static Future<void> generate({required String projectName}) async {
    var content = '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/generated/locale_keys.g.dart';
import 'package:$projectName/features/navigation/domain/entities/nav_bar_entity.dart';
import 'package:$projectName/features/navigation/presentation/widgets/nav_bar_item.dart';
import 'package:$projectName/core/util/extensions/extensions.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key, required this.statefulNavigationShell});

  final StatefulNavigationShell statefulNavigationShell;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> with TickerProviderStateMixin {
  final List<NavigationBarModel> navLabels = [
    NavigationBarModel(
      title: LocaleKeys.home,
      index: 0,
      selectedIcon: Icons.home,
      unSelectedIcon: Icons.home_outlined,
    ),
    NavigationBarModel(
      title: LocaleKeys.settings,
      index: 1,
      selectedIcon: Icons.settings,
      unSelectedIcon: Icons.settings_outlined,
    )
  ];

  late TabController tabController;

  ValueNotifier<int> currentNavIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (v) async {
        if (widget.statefulNavigationShell.currentIndex != 0) {
          currentNavIndex.value = 0;
          widget.statefulNavigationShell.goBranch(0);
        }
      },
      canPop: widget.statefulNavigationShell.currentIndex == 0,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: widget.statefulNavigationShell,
        bottomNavigationBar: Container(
          height: 70 + context.padding.bottom,
          padding: EdgeInsets.only(bottom: context.padding.bottom),
          decoration: BoxDecoration(
            color: context.appBarTheme.backgroundColor,
            border: const Border(top: BorderSide(color: Colors.grey)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF171725).withOpacity(0.05),
                blurRadius: 24,
                offset: const Offset(0, -8),
              )
            ],
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: currentNavIndex,
            builder: (ctx, value, child) {
              return TabBar(
                dividerColor: Colors.transparent,
                enableFeedback: true,
                onTap: (index) async {
                  currentNavIndex.value = index;
                  widget.statefulNavigationShell.goBranch(
                    index,
                    initialLocation: index == widget.statefulNavigationShell.currentIndex,
                  );
                },
                indicator: const BoxDecoration(),
                controller: tabController,
                labelPadding: EdgeInsets.zero,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  NavItemWidget(
                    currentIndex: value,
                    navigationBarModel: navLabels[0],
                  ),
                  NavItemWidget(
                    currentIndex: value,
                    navigationBarModel: navLabels[1],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

    ''';

    File('$projectName/lib/features/navigation/presentation/navigation_screen.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(content);
    });
  }
}
