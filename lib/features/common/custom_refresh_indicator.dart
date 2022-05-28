import 'package:bluetooth_hacker/resources/colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

const _defaultIndicatorSize = 125.0;
const _defaultOffsetToArmed = 80.0;

class CustomLoadingIndicator extends StatelessWidget {
  final Widget child;
  final OnRefresh onRefresh;
  final double? indicatorSize;
  final double? offsetToArmed;

  const CustomLoadingIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
    this.indicatorSize,
    this.offsetToArmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Tween<double> animationTween = Tween(begin: -1.0, end: 0.0);

    return CustomRefreshIndicator(
      offsetToArmed: offsetToArmed ?? _defaultOffsetToArmed,
      onRefresh: onRefresh,
      loadingToIdleDuration: const Duration(milliseconds: 250),
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
                final bool pause =
                    !(controller.isLoading || controller.isArmed);

                final double yOffset =
                    animationTween.transform(controller.value) *
                        _defaultIndicatorSize;

                final Offset offset = Offset(0, yOffset);

                return Transform.translate(
                  offset: offset,
                  child: Container(
                    alignment: Alignment.center,
                    height: _defaultIndicatorSize,
                    child: LoadingIndicator(
                      key: ValueKey(pause),
                      pause: pause,
                      indicatorType: Indicator.ballClipRotatePulse,
                      colors: const [LightColors.kLavender],
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0.0, controller.value * _defaultIndicatorSize),
                  child: child,
                );
              },
              animation: controller,
            ),
          ],
        );
      },
      child: child,
    );
  }
}
