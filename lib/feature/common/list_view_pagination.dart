import 'dart:io';

class ListPaginationGenerator {
  static Future<void> generate({required String projectName}) async {
    var listPagination = """
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:$projectName/features/common/presentation/widgets/pagination_loader.dart';

class ListPagination extends StatelessWidget {
  final FormzSubmissionStatus initialStatus;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final int itemCount;
  final VoidCallback fetchMoreFunction;
  final bool hasMoreToFetch;
  final Widget? errorWidget;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final Axis scrollDirection;
  final ScrollController? controller;

  const ListPagination({
    required this.initialStatus,
    required this.itemBuilder,
    this.separatorBuilder,
    this.errorWidget,
    required this.itemCount,
    required this.fetchMoreFunction,
    required this.hasMoreToFetch,
    this.shrinkWrap = false,
    this.padding,
    this.scrollDirection = Axis.vertical,
    super.key,
    this.physics,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (initialStatus.isInProgress) {
      return const Center(child: CircularProgressIndicator.adaptive());
    } else if (initialStatus.isFailure) {
      return errorWidget ?? const SizedBox.shrink();
    } else if (initialStatus.isSuccess) {
      return ListView.separated(
        controller: controller,
        padding: padding,
        scrollDirection: scrollDirection,
        shrinkWrap: shrinkWrap,
        physics: physics ?? const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == itemCount) {
            if (hasMoreToFetch) {
              fetchMoreFunction();
              return const Center(child: PaginationLoader());
            } else {
              return const SizedBox.shrink();
            }
          }
          return itemBuilder(context, index);
        },
        itemCount: itemCount + 1,
        separatorBuilder: separatorBuilder ?? (context, index) => const SizedBox.shrink(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
    """;

    var gridPagination = """
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
    
class GridPaginator extends StatelessWidget {
  final FormzSubmissionStatus paginationStatus;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final VoidCallback fetchMoreFunction;
  final bool hasMoreToFetch;
  final Widget errorWidget;
  final EdgeInsets? padding;
  final Widget? emptyWidget;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Axis scrollDirection;
  final Widget? loadingWidget;
  final SliverGridDelegate gridDelegate;
  final ScrollPhysics? physics;
  final Widget? paginationLoader;

  const GridPaginator({
    required this.paginationStatus,
    required this.itemBuilder,
    required this.itemCount,
    required this.fetchMoreFunction,
    required this.hasMoreToFetch,
    required this.errorWidget,
    required this.gridDelegate,
    this.padding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
    this.separatorBuilder,
    this.emptyWidget,
    this.loadingWidget,
    this.physics,
    this.paginationLoader,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (paginationStatus == FormzSubmissionStatus.inProgress) {
      return loadingWidget ?? const Center(child: CupertinoActivityIndicator());
    } else if (paginationStatus == FormzSubmissionStatus.failure) {
      return errorWidget;
    } else if (paginationStatus == FormzSubmissionStatus.success) {
      return itemCount == 0
          ? emptyWidget ?? const SizedBox.shrink()
          : GridView.builder(
              gridDelegate: gridDelegate,
              scrollDirection: scrollDirection,
              physics: physics ?? const BouncingScrollPhysics(),
              padding: padding,
              itemBuilder: (context, index) {
                if (itemCount == 0) {
                  return emptyWidget ?? const SizedBox.shrink();
                }
                if (index == itemCount) {
                  if (hasMoreToFetch) {
                    fetchMoreFunction();
                    return paginationLoader ?? const Center(child: CupertinoActivityIndicator());
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                return itemBuilder(context, index);
              },
              itemCount: itemCount + 1,
              shrinkWrap: true,
            );
    } else {
      return const SizedBox.shrink();
    }
  }
}
""";

    var paginationLoader = """
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:$projectName/core/util/extensions/extensions.dart'; 

class PaginationLoader extends StatefulWidget {
  const PaginationLoader({super.key});

  @override
  State<PaginationLoader> createState() => _PaginationLoaderState();
}

class _PaginationLoaderState extends State<PaginationLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (ctx, child) {
            return Transform.rotate(
              angle: _controller.value * pi,
              child: child,
            );
          },
          child: const Icon(CupertinoIcons.refresh_bold),
        ),
        const Gap(4),
        Text(
          'Loading...',
          style: context.textTheme.headlineSmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
""";

    File('$projectName/lib/features/common/presentation/widgets/list_pagination.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(listPagination);
    });
    File('$projectName/lib/features/common/presentation/widgets/grid_pagination.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(gridPagination);
    });
    File('$projectName/lib/features/common/presentation/widgets/pagination_loader.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(paginationLoader);
    });
  }
}
