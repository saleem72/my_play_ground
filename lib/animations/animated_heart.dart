// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';

class AnimatedHeart extends StatefulWidget {
  const AnimatedHeart({
    Key? key,
    required this.isFav,
    required this.onChange,
  }) : super(key: key);
  final bool isFav;
  final Function(bool) onChange;

  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late CurvedAnimation _curvedAnimation;
  late Animation<double> tweenSequence;
  late bool _isFav;
  @override
  void initState() {
    super.initState();

    _isFav = widget.isFav;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.slowMiddle,
    );

    tweenSequence = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(_curvedAnimation);

    _colorAnimation = ColorTween(begin: Colors.grey.shade400, end: Colors.red)
        .animate(_curvedAnimation);
    if (_isFav) {
      _controller.forward(from: 1);
    }
    // _controller.value = ;

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onChange(true);
        _isFav = true;
      } else if (status == AnimationStatus.dismissed) {
        widget.onChange(false);
        _isFav = false;
      }
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
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () {
            _isFav ? _controller.reverse() : _controller.forward();
          },
          child: Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: tweenSequence.value,
          ),
        );
      },
    );
  }
}
