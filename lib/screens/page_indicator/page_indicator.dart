//

import 'package:flutter/material.dart';

class PageIndicatorView extends StatelessWidget {
  const PageIndicatorView({
    Key? key,
    required this.pageCount,
    required this.selectedPage,
  }) : super(key: key);
  final int pageCount;
  final int selectedPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < pageCount; i++)
          if (selectedPage == i)
            const PageIndicatorDotView(isActive: true)
          else
            const PageIndicatorDotView(isActive: false)
      ],
    );
  }
}

class PageIndicatorDotView extends StatelessWidget {
  const PageIndicatorDotView({Key? key, required this.isActive})
      : super(key: key);
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color:
            (isActive == true) ? Colors.green.shade600 : Colors.grey.shade300,
      ),
    );
  }
}
