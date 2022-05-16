import 'package:bluetooth_hacker/features/scan/components/scan_configuration_dropdown/components/dropdown_panel.dart';
import 'package:bluetooth_hacker/features/scan/components/scan_configuration_dropdown/cubit/scan_configuration_cubit.dart';
import 'package:bluetooth_hacker/resources/colors.dart';
import 'package:flutter/material.dart' hide Expanded;
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanConfigurationDropdown extends StatefulWidget {
  const ScanConfigurationDropdown({
    required this.builder,
    Key? key,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  _ScanConfigurationDropdownState createState() =>
      _ScanConfigurationDropdownState();
}

class _ScanConfigurationDropdownState extends State<ScanConfigurationDropdown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );

  late final Animation<double> _lengthCoefficient =
      Tween<double>(begin: 0, end: 1)
          .chain(CurveTween(curve: decelerateEasing))
          .animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanConfigurationCubit, ScanConfigurationState>(
      listener: (_, state) {
        if (state is Expanded) {
          _controller.forward();
        } else if (state is Collapsed) {
          _controller.reverse();
        }
      },
      child: LayoutBuilder(builder: (_, constraints) {
        final Radius radius = Radius.circular(constraints.maxHeight * (1 / 20));
        final double maxHeight = constraints.maxHeight * (1 / 2);
        final double minHeight = maxHeight / 8;

        return Stack(
          children: [
            widget.builder(context),
            AnimatedBuilder(
              animation: _lengthCoefficient,
              builder: (_, child) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: radius,
                      bottomRight: radius,
                    ),
                  ),
                  color: LightColors.kDarkYellow,
                  shadowColor: LightColors.kDarkYellow
                      .withOpacity(_lengthCoefficient.value),
                  elevation: 4,
                  margin: EdgeInsets.zero,
                  child: child,
                );
              },
              child: AnimatedBuilder(
                animation: _lengthCoefficient,
                child: const DropDownPanel(),
                builder: (_, child) {
                  final double height = minHeight +
                      ((maxHeight - minHeight) * _lengthCoefficient.value);

                  return Container(
                    constraints: BoxConstraints(
                      minHeight: height,
                      maxHeight: height,
                    ),
                    child: SizedBox.expand(child: child),
                  );
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
