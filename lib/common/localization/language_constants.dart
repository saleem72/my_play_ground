//
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../dependency_injection.dart';
import '../local_storage/safe.dart';

Future<Locale> setLocal(BuildContext context, String languageCode) async {
  final Safe safe = locator();
  // final Translater translater = locator();
  final local = await safe.setLocal(languageCode);
  // translater.load(local);
  // MyApp.setLocal(context, local);
  return local;
}

Locale getLocal() {
  final Safe safe = locator();
  final local = safe.getLocal();
  return local;
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
