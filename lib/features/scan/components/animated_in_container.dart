import 'package:bluetooth_hacker/features/scan/bloc/scan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedInContainer extends StatefulWidget {
  const AnimatedInContainer({
    required this.id,
    required this.builder,
    Key? key,
  }) : super(key: key);

  final String id;
  final WidgetBuilder builder;

  @override
  _AnimatedInContainerState createState() => _AnimatedInContainerState();
}

class _AnimatedInContainerState extends State<AnimatedInContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 550),
  )..forward();

  late final _animation = CurvedAnimation(
    parent: _animationController,
    curve: decelerateEasing,
  );

  late final Animation<Offset> _offset = Tween<Offset>(
    begin: const Offset(1, 0),
    end: const Offset(0, 0),
  ).animate(_animation);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScanBloc, ScanState>(
      listener: (_, state) {
        if (state is ClearingScanResults ||
            !state.scanResults.containsKey(widget.id)) {
          _animationController
            ..stop(canceled: false)
            ..animateTo(-1, duration: ScanBloc.exitDuration);
        }
      },
      child: SlideTransition(
        position: _offset,
        child: widget.builder(context),
      ),
    );
  }
}
