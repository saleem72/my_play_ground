// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../common/localization/language_constants.dart';
import '../common/styles/route_generator.dart';

class AppPage {
  final String title;
  final String? description;
  final List<Color> colors;
  final AppRoute destination;
  AppPage({
    required this.title,
    this.description,
    required this.colors,
    required this.destination,
  });

  // static List<AppPage> get allPages {
  //   return [
  //     AppPage(
  //       title: 'sandbox',
  //       colors: [Colors.blue, Colors.purple],
  //       description:
  //           'dsfjshgfjshgfjs ajhdgfajgdjah asjdhgajsdgjahda ajshdgjahgdjahdga jhgasdjgajdgajd ajshgdjagdjahdg ajsdgjahgdjahgdja',
  //       destination: AppRoute.sandbox,
  //     ),
  //     AppPage(
  //       title: 'settings',
  //       colors: [Colors.blue, Colors.purple],
  //       destination: AppRoute.themeing,
  //     ),
  //     AppPage(
  //       title: 'Custom Bottom bar',
  //       colors: [Colors.blue, Colors.purple],
  //       destination: AppRoute.customBar,
  //     ),
  //     AppPage(
  //       title: 'network_monitor',
  //       colors: [Colors.blue, Colors.purple],
  //       destination: AppRoute.networkMonitor,
  //     ),
  //   ];
  // }

  static List<AppPage> allCases(BuildContext context) {
    return [
      AppPage(
        title: translation(context).sandbox,
        colors: [Colors.blue, Colors.purple],
        description:
            'dsfjshgfjshgfjs ajhdgfajgdjah asjdhgajsdgjahda ajshdgjahgdjahdga jhgasdjgajdgajd ajshgdjagdjahdg ajsdgjahgdjahgdja',
        destination: AppRoute.sandbox,
      ),
      AppPage(
        title: translation(context).settings,
        colors: [Colors.blue, Colors.purple],
        destination: AppRoute.themeing,
      ),
      AppPage(
        title: translation(context).custom_botttom_bar,
        colors: [Colors.blue, Colors.purple],
        destination: AppRoute.customBar,
      ),
      AppPage(
        title: 'Custom scrolling',
        colors: [Colors.blue, Colors.purple],
        destination: AppRoute.customScroll,
      ),
      AppPage(
        title: translation(context).network_monitor,
        colors: [Colors.blue, Colors.purple],
        destination: AppRoute.networkMonitor,
      ),
    ];
  }
}
