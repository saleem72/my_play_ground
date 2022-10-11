//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_play_ground/common/local_storage/safe.dart';
import 'package:my_play_ground/common/localization/cubit/locale_cubit.dart';
import 'package:my_play_ground/common/localization/language_constants.dart';
import 'package:my_play_ground/dependency_injection.dart';
import 'package:my_play_ground/main.dart';

class SettimgsScreen extends StatefulWidget {
  const SettimgsScreen({Key? key}) : super(key: key);

  @override
  State<SettimgsScreen> createState() => _SettimgsScreenState();
}

class _SettimgsScreenState extends State<SettimgsScreen> {
  late bool _isDarkMode;

  @override
  void initState() {
    _isDarkMode = Safe(storage: locator()).getThemeMode() == ThemeMode.dark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).settings),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          children: [
            Row(
              children: [
                Text(translation(context).dark_mode),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    MyApp.setTheme(context, value);
                    setState(() {
                      _isDarkMode = value;
                    });
                  },
                )
              ],
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            const LanguageOptions(),
          ],
        ),
      ),
    );
  }
}

class LanguageOptions extends StatefulWidget {
  const LanguageOptions({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageOptions> createState() => _LanguageOptionsState();
}

class _LanguageOptionsState extends State<LanguageOptions> {
  late bool _isEnglish;
  late bool _isArabic;

  @override
  void initState() {
    final Safe safe = locator();
    final locale = safe.getLocal();
    if (locale.languageCode == 'ar') {
      _isArabic = true;
      _isEnglish = false;
    } else {
      _isArabic = false;
      _isEnglish = true;
    }
    super.initState();
  }

  _handleArabicChanges(bool value) {
    setState(() {
      if (value) {
        _isEnglish = false;
        _isArabic = true;
        // setLocal(context, SafeKeys.arabic);
        context.read<LocaleCubit>().setLocal(context, SafeKeys.arabic);
      } else {
        _isEnglish = true;
        _isArabic = false;
        // setLocal(context, SafeKeys.english);
        context.read<LocaleCubit>().setLocal(context, SafeKeys.english);
      }
    });
  }

  _handleEnglishChanges(bool value) {
    setState(() {
      if (value) {
        _isEnglish = true;
        _isArabic = false;
        // setLocal(context, SafeKeys.english);
        context.read<LocaleCubit>().setLocal(context, SafeKeys.english);
      } else {
        _isEnglish = false;
        _isArabic = true;
        // setLocal(context, SafeKeys.arabic);
        context.read<LocaleCubit>().setLocal(context, SafeKeys.arabic);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(translation(context).language),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ListView(
            children: [
              Row(
                children: [
                  Text(translation(context).english), //
                  Switch(
                    value: _isEnglish,
                    onChanged: _handleEnglishChanges,
                  )
                ],
              ),
              Row(
                children: [
                  Text(translation(context).arabic), //
                  Switch(
                    value: _isArabic,
                    onChanged: _handleArabicChanges,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
