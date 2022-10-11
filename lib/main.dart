import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_play_ground/common/local_storage/safe.dart';
import 'package:my_play_ground/common/localization/cubit/locale_cubit.dart';
import 'package:my_play_ground/common/localization/translater.dart';
import 'package:my_play_ground/common/styles/app_theme.dart';
import 'package:my_play_ground/common/styles/route_generator.dart';
import 'package:my_play_ground/dependency_injection.dart' as di;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  //
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setTheme(BuildContext context, bool isDarkMode) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setTheme(isDarkMode);
  }
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _theme;
  late Locale _locale;
  final Translater _translater = di.locator();

  final Safe safe = di.locator();

  @override
  void initState() {
    _theme = safe.getThemeMode();
    _locale = safe.getLocal();
    _translater.load(_locale);
    super.initState();
  }

  void setTheme(bool isDarkMode) {
    setState(() {
      if (isDarkMode) {
        _theme = ThemeMode.dark;
        safe.setThemeMode('dark');
      } else {
        _theme = ThemeMode.light;
        safe.setThemeMode('light');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => LocaleCubit(safe: di.locator())))
      ],
      child: BlocListener<LocaleCubit, LocaleState>(
        listener: (context, state) {
          setState(() {
            _locale = state.locale;
          });
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
        ),
      ),
    );
  }
}
