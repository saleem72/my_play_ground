import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:my_play_ground/animations/animated_bottom_bar/animated_bottom_bar.dart';
import 'package:my_play_ground/animations/animated_header.dart';
import 'package:my_play_ground/animations/animated_heart.dart';
import 'package:my_play_ground/common/localization/language_constants.dart';

class SandBox extends StatefulWidget {
  const SandBox({Key? key}) : super(key: key);

  @override
  State<SandBox> createState() => _SandBoxState();
}

class _SandBoxState extends State<SandBox> {
  bool isLeft = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedHeader(text: translation(context).sandbox),
      ),
      body: Column(
        children: [
          const AnimatedBottomBar(),
          const SizedBox(height: 40),
          AnimatedHeart(
            isFav: true,
            onChange: (_) {},
          ),
          const SizedBox(height: 40),
          FlippingSwitch(
            color: Colors.amber,
            backgroundColor: Colors.white,
            leftLabel: 'On',
            rightLabel: 'Off',
            onChange: (isLeftActive) => setState(() {
              isLeft = isLeftActive;
            }),
          ),
          Text(isLeft.toString()),
        ],
      ),
    );
  }
}

class FlippingSwitch extends StatefulWidget {
  FlippingSwitch({
    Key? key,
    required this.color,
    required this.backgroundColor,
    required this.leftLabel,
    required this.rightLabel,
    this.onChange,
  }) : super(key: key);
  final Color color;
  final Color backgroundColor;
  final String leftLabel;
  final String rightLabel;
  final void Function(bool isLeftActive)? onChange;

  @override
  State<FlippingSwitch> createState() => _FlippingSwitchState();
}

class _FlippingSwitchState extends State<FlippingSwitch>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late AnimationController _tiltController;
  late Animation _tiltAnimation;

  final double _maxTiltAngle = math.pi / 6;
  double _directionMultiplier = 1.0;

  @override
  void initState() {
    super.initState();

    _tiltController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 1500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _tiltController.reverse();
        }
      });

    _tiltAnimation = CurvedAnimation(
      parent: _tiltController,
      curve: Curves.easeOut,
      reverseCurve: Curves.elasticOut.flipped,
    );

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _jumpToMode(true);
  }

  @override
  void dispose() {
    _tiltController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  void _jumpToMode(bool leftEnabled) {
    _flipController.value = leftEnabled ? 1 : 0;
  }

  void _flipSwitch() {
    if (_flipController.isCompleted) {
      _directionMultiplier = -1;
      _tiltController.forward();

      _flipController.reverse();
      widget.onChange?.call(false);
    } else {
      _directionMultiplier = 1;
      _tiltController.forward();

      _flipController.forward();
      widget.onChange?.call(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double height = 64;
    return AnimatedBuilder(
      animation: _tiltAnimation,
      builder: ((context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(
              _tiltAnimation.value * _maxTiltAngle * _directionMultiplier,
            ),
          alignment: const FractionalOffset(0.5, 1.0),
          child: child,
        );
      }),
      child: Stack(
        children: [
          _buildsTabsBackground(height),
          AnimatedBuilder(
              animation: _flipController,
              builder: (context, child) {
                return _buildFlippingSwitch(
                    math.pi * _flipController.value, height);
              }),
        ],
      ),
    );
  }

  Widget _buildFlippingSwitch(double angle, double height) {
    final bool isLeft = angle > (math.pi / 2);
    final double transformAngle = isLeft ? angle - math.pi : angle;

    return Positioned(
      top: 0,
      bottom: 0,
      right: isLeft ? null : 0,
      left: isLeft ? 0 : null,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(transformAngle),
        alignment:
            isLeft ? FractionalOffset(1.0, 1.0) : FractionalOffset(0.0, 1.0),
        child: Container(
          width: 125,
          height: height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.only(
              topRight: isLeft ? Radius.zero : Radius.circular(height / 2),
              bottomRight: isLeft ? Radius.zero : Radius.circular(height / 2),
              topLeft: isLeft ? Radius.circular(height / 2) : Radius.zero,
              bottomLeft: isLeft ? Radius.circular(height / 2) : Radius.zero,
            ),
          ),
          child: Center(
            child: Text(
              isLeft ? widget.leftLabel : widget.rightLabel,
              style: TextStyle(
                color: widget.backgroundColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildsTabsBackground(double height) {
    return GestureDetector(
      onTap: () => _flipSwitch(),
      child: Container(
        width: 250,
        height: height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(height / 2),
          border: Border.all(
            color: widget.color,
            width: 5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  widget.leftLabel,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.rightLabel,
                  style: TextStyle(
                    color: widget.color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
