import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Translater {
  Map<String, String> _localizedString = <String, String>{};

  Future<bool> load(Locale locale) async {
    //Load the language JSON file from the "lang" folder
    String jsonString =
        await rootBundle.loadString('lib/l10n/app_${locale.languageCode}.arb');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedString = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  //This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedString[key] ?? key;
  }
}
