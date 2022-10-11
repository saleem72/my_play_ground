// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';

class AnimatedBottomBarbackground extends StatefulWidget {
  final double start;
  final double end;

  const AnimatedBottomBarbackground({
    Key? key,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  State<AnimatedBottomBarbackground> createState() =>
      _AnimatedBottomBarbackgroundState();
}

class _AnimatedBottomBarbackgroundState
    extends State<AnimatedBottomBarbackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _posAnimation;
  bool _isDone = false;

  @override
  void didUpdateWidget(covariant AnimatedBottomBarbackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    initAnimation();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isDone = true;
        } else if (status == AnimationStatus.dismissed) {
          _isDone = false;
        }
      });

    initAnimation();
  }

  initAnimation() {
    _posAnimation = Tween<double>(begin: widget.start, end: widget.end)
        .animate(_controller);
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
        animation: _controller,
        builder: ((context, child) {
          return GestureDetector(
            onTap: () {
              _isDone ? _controller.reverse() : _controller.forward();
            },
            child: SizedBox(
              height: 60,
              width: size.width,
              child: CustomPaint(
                isComplex: true,
                painter: AnimatedBottomBarPainter(pos: _posAnimation.value),
              ),
            ),
          );
        }));
  }
}

class AnimatedBottomBarPainter extends CustomPainter {
  final double pos;

  AnimatedBottomBarPainter({
    required this.pos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.pink;
    final path = animatedBottomBarShape(size, pos);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white;
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Path animatedBottomBarShape(Size size, double pos) {
  const diff = 20.0;
  final path = Path();
  path.moveTo(0, 0);

  path.lineTo(pos - diff, 0);
  path.quadraticBezierTo(
      pos - (diff * 0.75), 0, pos - (diff * 0.5), diff * 0.5);
  path.quadraticBezierTo(pos - (diff * 0.5), diff, pos, diff);

  path.quadraticBezierTo(
      pos + (diff * 0.5), diff, pos + (diff * 0.5), diff * 0.5);

  path.quadraticBezierTo(pos + (diff * 0.75), 0, pos + diff, 0);

  path.lineTo(size.width, 0);
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  path.lineTo(0, 0);
  return path;
}
