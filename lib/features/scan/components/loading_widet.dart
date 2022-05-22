import 'package:bluetooth_hacker/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: (1 / 2).sw,
        width: (1 / 2).sw,
        child: AspectRatio(
          aspectRatio: 1,
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular((1 / 2).sw),
                      ),
                    ),
                    color: LightColors.kDarkYellow,
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: constraints,
                    child: Transform.scale(
                      scale: 2,
                      child: const CircularProgressIndicator.adaptive(),
                    ),
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
