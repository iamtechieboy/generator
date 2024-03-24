import 'dart:io';

class NavBarItemGenerator {
  static Future<void> generate({required String projectName}) async {
    var content = """
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:$projectName/core/util/extensions/extensions.dart';
import 'package:$projectName/features/navigation/domain/entities/nav_bar_entity.dart';

class NavItemWidget extends StatelessWidget {
  final int currentIndex;
  final NavigationBarModel navigationBarModel;

  const NavItemWidget({
    required this.currentIndex,
    required this.navigationBarModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelectedIcon(),
          ),
          const Gap(6),
          Text(
            navigationBarModel.title.tr(),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: context.textTheme.headlineSmall!.copyWith(fontSize: 11, color: isSelectedColor()),
          ),
        ],
      );

  Color? isSelectedColor() => currentIndex != navigationBarModel.index ? Colors.red : null;

  IconData isSelectedIcon() {
    return currentIndex == navigationBarModel.index
        ? navigationBarModel.selectedIcon
        : navigationBarModel.unSelectedIcon;
  }
}
    """;

    File('$projectName/lib/features/navigation/presentation/widgets/nav_bar_item.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(content);
    });
  }
}
