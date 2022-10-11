// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theming_manager_state.dart';

class ThemingManagerCubit extends Cubit<ThemingManagerState> {
  ThemingManagerCubit({
    required ThemingManagerStateMode initialMode,
  }) : super(ThemingManagerState(mode: initialMode));
}
