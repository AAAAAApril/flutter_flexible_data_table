import 'package:flutter/widgets.dart';

class LazyLayoutBuilder extends StatelessWidget {
  const LazyLayoutBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, double viewportWidth) builder;

  @override
  Widget build(BuildContext context) {
    Widget? cache;
    double? lastWidth;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (cache == null || lastWidth != constraints.maxWidth) {
          lastWidth = constraints.maxWidth;
          cache = builder.call(context, constraints.maxWidth);
        }
        return cache!;
      },
    );
  }
}

class LazySliverLayoutBuilder extends StatelessWidget {
  const LazySliverLayoutBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, double viewportWidth) builder;

  @override
  Widget build(BuildContext context) {
    Widget? cache;
    double? lastWidth;
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        if (cache == null || lastWidth != constraints.crossAxisExtent) {
          lastWidth = constraints.crossAxisExtent;
          cache = builder.call(context, constraints.crossAxisExtent);
        }
        return cache!;
      },
    );
  }
}
