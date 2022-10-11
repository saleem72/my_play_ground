import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:my_play_ground/common/local_storage/safe.dart';

import '../../../dependency_injection.dart' as di;
import '../translater.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final Safe _safe;
  LocaleState _state;

  LocaleCubit({required Safe safe})
      : _safe = safe,
        _state = LocaleState(locale: safe.getLocal()),
        super(LocaleState(locale: safe.getLocal()));

  Future<Locale> setLocal(BuildContext context, String languageCode) async {
    final Translater translater = di.locator();
    final local = await _safe.setLocal(languageCode);
    translater.load(local);
    _state = LocaleState(locale: local);
    emit(_state);
    return local;
  }

  Locale getLocal() {
    final local = _safe.getLocal();
    return local;
  }
}
