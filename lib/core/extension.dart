part of 'core.dart';

/// Generate extension class
class ExtensionClassGenerator {
  static Future<void> generate(projectName) async {
    print("🛠️ Generating extension class...");

    Directory('$projectName/lib/core/util/extensions').createSync(recursive: true);
    final extensionDirectory = File('$projectName/lib/core/util/extensions/extensions.dart');

    extensionDirectory.writeAsStringSync(
      """
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:$projectName/core/util/enums/enums.dart';
import 'package:$projectName/features/common/presentation/widgets/popup_container.dart';


extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  Size get sizeOf => MediaQuery.sizeOf(this);

  Brightness get brightness => theme.brightness;

  AppBarThemeData get appBarTheme => theme.appBarTheme;

  Future<void> showPopUp(
    BuildContext context,
    PopUpStatus status, {
    required String message,
    Widget? child,
    double? height,
  }) async {
    AnimationController? localAnimationController;
    showTopSnackBar(
      Overlay.of(this),
      child ??
          PopUpContainer(
            status: status,
            message: message,
            onCancel: () {
              if (localAnimationController != null) localAnimationController!.reverse();
            },
          ),
      displayDuration: const Duration(seconds: 3),
      dismissType: status.isWarning ? DismissType.onSwipe : DismissType.none,
      curve: Curves.decelerate,
      reverseCurve: Curves.linear,
      onAnimationControllerInit: (p0) => localAnimationController = p0,
      animationDuration: const Duration(milliseconds: 400),
      reverseAnimationDuration: const Duration(milliseconds: 300),
    );
  }
}

extension CrossFade on CrossFadeState {
  bool get isShowFirst => this == CrossFadeState.showFirst;

  bool get isShowSecond => this == CrossFadeState.showSecond;
}
  """,
    );
    print("Done ✅");
  }
}
