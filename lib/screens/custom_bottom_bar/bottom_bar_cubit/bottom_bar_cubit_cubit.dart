//

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_play_ground/screens/custom_bottom_bar/models/custom_bottom_bar_page.dart';

part 'bottom_bar_cubit_state.dart';

class BottomBarCubitCubit extends Cubit<BottomBarCubitState> {
  BottomBarCubitState status = BottomBarCubitState(
      page: CustomBottomBarPage.allPages.first, position: const Offset(30, 0));

  BottomBarCubitCubit()
      : super(BottomBarCubitState(
            page: CustomBottomBarPage.allPages.first,
            position: const Offset(30, 0)));

  void pageChanedTo(CustomBottomBarPage page, Offset position) {
    status = BottomBarCubitState(page: page, position: position);
    emit(status);
  }
}
