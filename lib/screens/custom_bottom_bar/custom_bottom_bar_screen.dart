// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_play_ground/animations/animated_header.dart';
import 'package:my_play_ground/common/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:my_play_ground/common/localization/language_constants.dart';
import 'package:my_play_ground/common/styles/app_fonts.dart';

import 'bottom_bar_cubit/bottom_bar_cubit_cubit.dart';

class CustomBottomBarScreen extends StatefulWidget {
  const CustomBottomBarScreen({Key? key}) : super(key: key);

  @override
  State<CustomBottomBarScreen> createState() => _CustomBottomBarScreenState();
}

class _CustomBottomBarScreenState extends State<CustomBottomBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedHeader(text: translation(context).custom_botttom_bar),
      ),
      body: BlocProvider(
        create: ((context) => BottomBarCubitCubit()),
        child: BlocBuilder<BottomBarCubitCubit, BottomBarCubitState>(
          builder: (context, state) => _content(context, state),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, BottomBarCubitState state) {
    return Stack(
      children: [
        _currentPage(state),
        const Align(
          alignment: Alignment.bottomCenter,
          child: CustomBottomBar(),
        ),
      ],
    );
  }

  Widget _currentPage(BottomBarCubitState state) {
    return CurrentPage(title: state.page.title);
  }
}

class CurrentPage extends StatelessWidget {
  const CurrentPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 150),
        Center(
          child: Text(
            title,
            style: AppFonts.titleStyle,
          ),
        ),
      ],
    );
  }
}
