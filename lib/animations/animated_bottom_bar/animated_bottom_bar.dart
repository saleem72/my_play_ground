//

import 'package:flutter/material.dart';
import 'package:my_play_ground/animations/animated_bottom_bar/animated_bottom_bar_background.dart';

class AnimatedBottomBar extends StatefulWidget {
  const AnimatedBottomBar({Key? key}) : super(key: key);

  @override
  State<AnimatedBottomBar> createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {
  double start = 0;
  double end = 20;
  int selectedIndex = 0;

  setSelected(GlobalKey key, int value) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    setState(() {
      selectedIndex = value;
      start = end;
      end = (position?.dx ?? 0) + ((box?.size.width ?? 0) / 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 60,
      width: size.width,
      child: Stack(
        children: [
          _background(start, end),
          Container(
            height: 60,
            width: size.width,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomBarButton(
                  icon: Icons.home,
                  index: 0,
                  selectedIndex: selectedIndex,
                  onTap: setSelected,
                  onCreate: setSelected,
                ),
                BottomBarButton(
                  icon: Icons.person,
                  index: 1,
                  selectedIndex: selectedIndex,
                  onTap: setSelected,
                ),
                BottomBarButton(
                  icon: Icons.location_on,
                  index: 2,
                  selectedIndex: selectedIndex,
                  onTap: setSelected,
                ),
                BottomBarButton(
                  icon: Icons.settings,
                  index: 3,
                  selectedIndex: selectedIndex,
                  onTap: setSelected,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _background(double animStart, double animEnd) {
    return AnimatedBottomBarbackground(start: animStart, end: animEnd);
  }
}

class BottomBarButton extends StatefulWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final Function(GlobalKey, int) onTap;
  final Function(GlobalKey, int)? onCreate;

  const BottomBarButton({
    Key? key,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    this.onCreate,
  }) : super(key: key);

  @override
  State<BottomBarButton> createState() => _BottomBarButtonState();
}

class _BottomBarButtonState extends State<BottomBarButton> {
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.onCreate != null) {
        widget.onCreate!(_key, widget.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: IconButton(
        onPressed: () {
          widget.onTap(_key, widget.index);
        },
        icon: Icon(
          widget.icon,
          color: widget.selectedIndex == widget.index
              ? Colors.white
              : Colors.white54,
        ),
      ),
    );
  }
}
