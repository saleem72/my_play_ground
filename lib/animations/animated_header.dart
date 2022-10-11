//

import 'package:flutter/material.dart';
import 'package:my_play_ground/common/styles/app_fonts.dart';

class AnimatedHeader extends StatefulWidget {
  const AnimatedHeader({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  State<AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed(const Duration(milliseconds: 200), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: 56,
          child: Padding(
            padding: EdgeInsets.only(top: _curvedAnimation.value * 20),
            child: Opacity(
              opacity: _controller.value,
              child: child,
            ),
          ),
        );
      },
      child: Text(
        widget.text,
        style: AppFonts.titleStyle.copyWith(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
