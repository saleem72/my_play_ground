//

import 'package:get_it/get_it.dart';
import 'package:my_play_ground/common/local_storage/safe.dart';
import 'package:my_play_ground/common/localization/translater.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<dynamic> initDependencies() async {
  final storage = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(storage);
  locator.registerSingleton(Safe(storage: locator()));

  locator.registerLazySingleton(() => Translater());

  return dynamic;
}
