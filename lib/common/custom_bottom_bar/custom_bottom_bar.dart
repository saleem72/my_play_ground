//

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_play_ground/screens/custom_bottom_bar/bottom_bar_cubit/bottom_bar_cubit_cubit.dart';
import 'package:my_play_ground/screens/custom_bottom_bar/models/custom_bottom_bar_page.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

// context.read<CounterCubit>().increment()
class _CustomBottomBarState extends State<CustomBottomBar> {
  final List<CustomBottomBarPage> pages = CustomBottomBarPage.allPages;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 80,
      width: size.width,
      child: Stack(
        children: [
          const AnimatedCustomBottomBarBackground(),
          _buttons(),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            pages.map((page) => CutomBottomBarButton(page: page)).toList(),
      ),
    );
  }
}

class CutomBottomBarButton extends StatefulWidget {
  final CustomBottomBarPage page;

  const CutomBottomBarButton({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  State<CutomBottomBarButton> createState() => _CutomBottomBarButtonState();
}

class _CutomBottomBarButtonState extends State<CutomBottomBarButton> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.page.index == 0) {
        _pressed(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // key: _key,
      height: 44,
      width: 44,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: IconButton(
          key: _key,
          onPressed: () {
            _pressed(context);
          },
          icon: Icon(
            widget.page.icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _pressed(BuildContext context) {
    RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox?;
    Offset boxPosition = box?.localToGlobal(Offset.zero) ?? const Offset(0, 0);
    final Offset position =
        Offset(boxPosition.dx + (box?.size.width ?? 0) / 2, boxPosition.dy);
    context.read<BottomBarCubitCubit>().pageChanedTo(widget.page, position);
  }
}

class AnimatedCustomBottomBarBackground extends StatefulWidget {
  const AnimatedCustomBottomBarBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedCustomBottomBarBackground> createState() =>
      _AnimatedCustomBottomBarBackgroundState();
}

class _AnimatedCustomBottomBarBackgroundState
    extends State<AnimatedCustomBottomBarBackground> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<BottomBarCubitCubit, BottomBarCubitState>(
        builder: (context, state) {
          return TweenAnimationBuilder(
            duration: const Duration(milliseconds: 200),
            tween: Tween<double>(begin: 0, end: state.position.dx),
            builder: (BuildContext context, dynamic value, Widget? child) {
              return CustomPaint(
                isComplex: true,
                painter: AnimatedCustomBottomBarPainter(pos: value),
              );
            },
          );
        },
      ),
    );
  }
}

class AnimatedCustomBottomBarPainter extends CustomPainter {
  final double pos;

  AnimatedCustomBottomBarPainter({
    required this.pos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final box = Rect.fromLTWH(0, 0, size.width, size.height);
    const gradient = LinearGradient(
      colors: [Color(0xff2C5364), Color(0xff203A43), Color(0xff0F2027)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    final paint = Paint()..shader = gradient.createShader(box);
    final path = customBottomBarShape(size, pos);

    canvas.save();
    canvas.translate(0, -8);
    canvas.drawShadow(path, Colors.white, math.sqrt(16), false);
    canvas.restore();

    canvas.drawPath(path, paint);
    // canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Path customBottomBarShape(Size size, double pos) {
  const double diff = 20.0;
  const double raduis = 20.0;
  final path = Path();

  path.moveTo(0, raduis);
  const leftOval = Rect.fromLTRB(0, 0, raduis * 2, raduis * 2);
  path.addArc(leftOval, degreeToRadian(180), degreeToRadian(90));

  path.lineTo(pos - diff, 0);
  path.quadraticBezierTo(
      pos - (diff * 0.75), 0, pos - (diff * 0.5), diff * 0.5);
  path.quadraticBezierTo(pos - (diff * 0.5), diff, pos, diff);

  path.quadraticBezierTo(
      pos + (diff * 0.5), diff, pos + (diff * 0.5), diff * 0.5);

  path.quadraticBezierTo(pos + (diff * 0.75), 0, pos + diff, 0);

  path.lineTo(size.width - raduis, 0);

  final rightOval =
      Rect.fromLTRB(size.width - raduis * 2, 0, size.width, raduis * 2);
  path.addArc(rightOval, degreeToRadian(270), degreeToRadian(90));

  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  path.lineTo(0, raduis);
  path.close();

  return path;
}

double degreeToRadian(double angle) {
  // 1 rad = 180°/π 1 deg = (1 rad * π)/180
  // number * .pi / 180
  return angle * math.pi / 180;
}
