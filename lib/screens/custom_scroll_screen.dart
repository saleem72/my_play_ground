// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'dart:async';

import 'package:flutter/material.dart';

import 'page_indicator/animated_page_view_indicator.dart';
import 'page_indicator/page_indicator.dart';

class CustomScrollScreen extends StatefulWidget {
  const CustomScrollScreen({Key? key}) : super(key: key);

  @override
  State<CustomScrollScreen> createState() => _CustomScrollScreenState();
}

class _CustomScrollScreenState extends State<CustomScrollScreen> {
  final PageController _controller = PageController();
  final List<IconData> pages = [
    Icons.person,
    Icons.home,
    Icons.search,
    Icons.location_city,
  ];
  int selectedPage = 0;
  late Timer timer;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        if (mounted) {
          if (selectedPage == pages.length - 1) {
            selectedPage = 0;
          } else {
            selectedPage++;
          }
        }
      });
      _controller.animateToPage(
        selectedPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  _pageChanged(int page) {
    setState(() => selectedPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Indicator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                onPageChanged: _pageChanged,
                children: pages
                    .map((page) => Container(
                          child: Icon(
                            page,
                            size: 84,
                          ),
                        ))
                    .toList()),
          ),
          AnimatedPageViewIndicator(
            pageCount: pages.length,
            animation: _controller,
          ),
          const SizedBox(height: 30),
          PageIndicatorView(
            selectedPage: selectedPage,
            pageCount: pages.length,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            child: const Text('Tap Me'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
