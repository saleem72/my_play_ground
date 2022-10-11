import 'package:flutter/material.dart';
import 'package:my_play_ground/screens/custom_bottom_bar/custom_bottom_bar_screen.dart';
import 'package:my_play_ground/screens/custom_scroll_screen.dart';
import 'package:my_play_ground/screens/launch_screen.dart';
import 'package:my_play_ground/screens/main_screen.dart';
import 'package:my_play_ground/screens/network_monitor_screen/network_monitor_screen.dart';
import 'package:my_play_ground/screens/sand_box.dart';

import '../../screens/settings_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: ((context) => const LaunchScreen()));
      case '/main':
        return MaterialPageRoute(builder: ((context) => const MainScreen()));
      case '/sandbox':
        return MaterialPageRoute(builder: ((context) => const SandBox()));
      case '/networkMonitor':
        return MaterialPageRoute(
            builder: ((context) => const NetworkMonitorScreen()));
      case '/theming':
        return MaterialPageRoute(
            builder: ((context) => const SettimgsScreen()));
      case '/customBar':
        return MaterialPageRoute(
            builder: ((context) => const CustomBottomBarScreen()));
      case '/customScroll':
        return MaterialPageRoute(builder: ((context) => CustomScrollScreen()));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: ((context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    }));
  }
}

enum AppRoute {
  initial,
  main,
  sandbox,
  networkMonitor,
  themeing,
  customBar,
  customScroll,
}

extension AppRoutePath on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.initial:
        return '/';
      case AppRoute.main:
        return '/main';
      case AppRoute.sandbox:
        return '/sandbox';
      case AppRoute.networkMonitor:
        return '/networkMonitor';
      case AppRoute.themeing:
        return '/theming';
      case AppRoute.customBar:
        return '/customBar';
      case AppRoute.customScroll:
        return '/customScroll';
    }
  }
}
