//

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CustomBottomBarPage extends Equatable {
  final int index;
  final String title;
  final IconData icon;

  const CustomBottomBarPage({
    required this.index,
    required this.title,
    required this.icon,
  });

  static List<CustomBottomBarPage> get allPages {
    return [
      const CustomBottomBarPage(index: 0, title: 'Home', icon: Icons.home),
      const CustomBottomBarPage(index: 1, title: 'Search', icon: Icons.search),
      const CustomBottomBarPage(index: 2, title: 'Profile', icon: Icons.person),
      const CustomBottomBarPage(
          index: 3, title: 'Settings', icon: Icons.settings),
    ];
  }

  @override
  List<Object?> get props => [index];
}
