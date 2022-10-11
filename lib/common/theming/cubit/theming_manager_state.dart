// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theming_manager_cubit.dart';

enum ThemingManagerStateMode { dark, light }

class ThemingManagerState extends Equatable {
  final ThemingManagerStateMode mode;

  const ThemingManagerState({
    required this.mode,
  });

  @override
  List<Object?> get props => [mode];

  static Future<ThemingManagerState> initialMode() async {
    await Future.delayed(const Duration(seconds: 1));
    return const ThemingManagerState(mode: ThemingManagerStateMode.dark);
  }
}
