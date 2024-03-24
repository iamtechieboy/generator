import 'dart:io';

class CommonWidgetsGenerator {
  static Future<void> generate({required String projectName}) async {
    /// Scale animation widget
    File('$projectName/lib/features/common/presentation/widgets/scale_animation_widget.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString("""
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScaleAnimationWidget extends StatefulWidget {
  final int id;
  final Widget child;
  final VoidCallback onTap;
  final Duration duration;
  final double scaleValue;
  final bool isDisabled;

  const ScaleAnimationWidget({
    required this.child,
    required this.onTap,
    super.key,
    this.id = 1,
    this.isDisabled = false,
    this.duration = const Duration(milliseconds: 150),
    this.scaleValue = 0.98,
  }) : assert(scaleValue <= 1 && scaleValue >= 0, 'Range error: Range should be between [0,1]');

  @override
  _ScaleAnimationWidgetState createState() => _ScaleAnimationWidgetState();
}

class _ScaleAnimationWidgetState extends State<ScaleAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: widget.scaleValue,
    ).animate(
      CurvedAnimation(
        curve: Curves.decelerate,
        parent: _controller,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!widget.isDisabled) {
            widget.onTap();
          }
        },
        onPanDown: (details) {
          if (!widget.isDisabled) {
            _controller.forward();
          }
        },
        onPanCancel: () {
          if (!widget.isDisabled) {
            _controller.reverse();
          }
        },
        onPanEnd: (details) {
          if (!widget.isDisabled) {
            _controller.reverse();
          }
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: widget.child,
        ),
      );
}      
      """);
    });

    /// Custom button widget
    File('$projectName/lib/features/common/presentation/widgets/custom_button.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString("""
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:$projectName/core/util/extensions/extensions.dart';
import 'package:$projectName/features/common/presentation/widgets/scale_animation_widget.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? color;
  final Color textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final BoxBorder? border;
  final double borderRadius;
  final Widget? child;
  final Color disabledColor;
  final bool isDisabled;
  final bool isLoading;
  final double? scaleValue;
  final List<BoxShadow>? shadow;
  final Gradient? gradient;

  const CustomButton({
    required this.onTap,
    this.text = '',
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8,
    this.disabledColor = Colors.grey,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.textStyle,
    this.border,
    this.child,
    this.scaleValue,
    this.shadow,
    this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ScaleAnimationWidget(
        scaleValue: scaleValue ?? 0.98,
        onTap: () {
          if (!(isLoading || isDisabled)) {
            onTap();
          }
        },
        isDisabled: isDisabled,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          height: height ?? 44,
          margin: margin,
          padding: padding ?? EdgeInsets.zero,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDisabled ? disabledColor : color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
            boxShadow: shadow,
            gradient: gradient,
          ),
          child: isLoading
              ? const Center(child: CupertinoActivityIndicator(color: Colors.white))
              : AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style:
                      context.textTheme.labelLarge!.copyWith(color: isDisabled ? Colors.grey : textColor),
                  child: Text(
                            text,
                            style: textStyle,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                ),
        ),
      );
}   
      """);
    });

    /// Image pre loader widget
    File('$projectName/lib/features/common/presentation/widgets/image_preloader.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString("""
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImagePreloadShimmer extends StatelessWidget {
  const ImagePreloadShimmer({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Positioned(
              top: 0,
              right: -1,
              left: 0,
              bottom: 0,
              child: Container(color: Colors.white),
            ),
            Shimmer(
              gradient: const LinearGradient(begin: Alignment.centerRight, end: Alignment.centerLeft, colors: <Color>[
                Color.fromRGBO(231, 235, 240, 1),
                Color.fromRGBO(231, 235, 240, 1),
                Color.fromRGBO(251, 251, 251, 0.8),
                Color.fromRGBO(231, 235, 240, 1),
                Color.fromRGBO(231, 235, 240, 1),
              ], stops: <double>[
                0,
                0.35,
                0.5,
                0.65,
                2,
              ]),
              period: const Duration(seconds: 2),
              direction: ShimmerDirection.ltr,
              child: Container(decoration: const BoxDecoration(color: Colors.white)),
            ),
          ],
        ),
      );
}
      """);
    });

    /// Custom image view widget
    File('$projectName/lib/features/common/presentation/widgets/custom_imageview.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString("""
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:$projectName/features/common/presentation/widgets/image_preloader.dart';

class CustomImageView extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Color borderColor;
  final double borderWidth;

  const CustomImageView({
    this.imageUrl = "",
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.color,
    this.borderRadius,
    super.key,
    this.placeholder,
    this.errorWidget,
    this.borderColor=Colors.transparent,
    this.borderWidth=0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: borderRadius ?? BorderRadius.circular(0),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          color: color,
          fit: fit,
          placeholder: (context, url) =>
              placeholder ?? const ImagePreloadShimmer(),
          errorWidget: (context, url, error) =>
              errorWidget ??
               const Icon(Icons.error_outline_rounded),
        ),
      ),
    );
  }
}  
      """);
    });

    /// Pup container view widget
    File('$projectName/lib/features/common/presentation/widgets/popup_container.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString("""
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:$projectName/core/config/app_icons.dart';
import 'package:$projectName/core/util/enums/extensions.dart';
import 'package:$projectName/core/util/extensions/extensions.dart';

class PopUpContainer extends StatefulWidget {
  final PopUpStatus status;
  final VoidCallback? onCancel;
  final String message;

  const PopUpContainer({super.key, required this.status, required this.message, required this.onCancel});

  @override
  State<PopUpContainer> createState() => _PopUpContainerState();
}

class _PopUpContainerState extends State<PopUpContainer> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 3), value: 1)..reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 3),
            blurRadius: 22,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: widget.status.color,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white.withOpacity(0.36)),
            ),
            child: SvgPicture.asset(widget.status.icon),
          ),
          Expanded(
            child: Text(widget.message, style: context.textTheme.headlineLarge, textAlign: TextAlign.start),
          ),
          if (!widget.status.isWarning) ...{
            AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget? child) {
                if (animationController.value == 0) {
                  return const SizedBox(
                    height: 28,
                    width: 28,
                  );
                }
                return GestureDetector(
                  onTap: widget.onCancel,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.flip(
                        flipX: true,
                        child: SizedBox(
                          height: 28,
                          width: 28,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                            strokeWidth: 1.6,
                            value: animationController.value,
                          ),
                        ),
                      ),
                      SvgPicture.asset(AppIcons.close, height: 24, width: 24),
                    ],
                  ),
                );
              },
            )
          }
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
      """);
    });
  }
}
