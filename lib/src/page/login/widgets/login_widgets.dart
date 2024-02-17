import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math' as math;

class RotatingWidget extends StatefulWidget {
  const RotatingWidget();

  @override
  State<RotatingWidget> createState() => _RotatingWidgetState();
}

class _RotatingWidgetState extends State<RotatingWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 8))
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (MediaQuery.of(context).size.width / 2) - 30,
      top: 25,
      child: AnimatedBuilder(
        animation: _controller,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "assets/images/spaceship.PNG",
            width: 80,
            height: 80,
            opacity: const AlwaysStoppedAnimation(.9),
          ),
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 3.0 * math.pi,
            child: child,
          );
        },
      ),
    );
  }
}
