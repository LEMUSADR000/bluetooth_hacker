import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

const double _kDefaultIndicatorRadius = 20.0;

typedef WrapperWidgetBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

class PlatformRefreshIndicator extends StatefulWidget {
  final Widget child;
  final OnRefresh onRefresh;
  final double indicatorSize;
  final double? offsetToArmed;
  final PlatformBuilder<MaterialProgressIndicatorData>? material;
  final PlatformBuilder<CupertinoProgressIndicatorData>? cupertino;
  final ScrollNotificationPredicate predicate;

  const PlatformRefreshIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
    required this.indicatorSize,
    this.offsetToArmed,
    this.material,
    this.cupertino,
    this.predicate = defaultScrollNotificationPredicate,
  }) : super(key: key);

  @override
  _PlatformRefreshIndicatorState createState() =>
      _PlatformRefreshIndicatorState();
}

class _PlatformRefreshIndicatorState extends State<PlatformRefreshIndicator>
    with SingleTickerProviderStateMixin {
  final IndicatorController _controller = IndicatorController();

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      controller: _controller,
      offsetToArmed: widget.offsetToArmed,
      onRefresh: widget.onRefresh,
      completeStateDuration: Duration.zero,
      notificationPredicate: widget.predicate,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, _) {
                final containerHeight = controller.value * widget.indicatorSize;

                final Widget child = PlatformWidget(
                  cupertino: (_, __) {
                    final data =
                        widget.cupertino?.call(context, platform(context));

                    final Widget child;
                    if (controller.isLoading || controller.isArmed) {
                      child = CupertinoActivityIndicator(
                        radius: data?.radius ?? _kDefaultIndicatorRadius,
                        color: data?.color,
                      );
                    } else {
                      child = CupertinoActivityIndicator.partiallyRevealed(
                        key: data?.key ?? widget.key,
                        radius: data?.radius ?? _kDefaultIndicatorRadius,
                        progress: controller.value.clamp(0.0, 1.0),
                        color: data?.color,
                      );
                    }

                    return child;
                  },
                  material: (_, __) {
                    final data =
                        widget.material?.call(context, platform(context));

                    return RefreshIndicator(
                      onRefresh: widget.onRefresh,
                      key: data?.key ?? widget.key,
                      backgroundColor: data?.backgroundColor,
                      color: data?.color,
                      strokeWidth: data?.strokeWidth ?? 2.0,
                      semanticsLabel: data?.semanticsLabel,
                      semanticsValue: data?.semanticsValue,
                      child: widget.child,
                    );
                  },
                );

                return Container(
                  constraints: BoxConstraints(
                    minHeight: containerHeight,
                    maxHeight: containerHeight,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: child,
                );
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(
                    0.0,
                    controller.value * widget.indicatorSize,
                  ),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}
