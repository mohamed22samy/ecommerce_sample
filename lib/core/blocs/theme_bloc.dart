import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/app_color.dart';
import '../utils/app_color_scheme.dart';
import '../utils/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final _storage = const FlutterSecureStorage();
  static const String _themeKey = 'app_theme';

  ThemeBloc() : super(ThemeState()) {
    on<DarkThemeEvent>(_darkTheme);
    on<LightThemeEvent>(_lightTheme);
    on<ToggleThemeEvent>(_toggleTheme);
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final themeStr = await _storage.read(key: _themeKey);
    final isDark = themeStr == 'dark';
    add(isDark ? DarkThemeEvent() : LightThemeEvent());
  }

  Future<void> _saveTheme(bool isDark) async {
    await _storage.write(
      key: _themeKey,
      value: isDark ? 'dark' : 'light',
    );
  }

  FutureOr<void> _darkTheme(DarkThemeEvent event, Emitter<ThemeState> emit) async {
    print('dark');
    emit(state.copyWith(
      isDark: true,
      themeData: AppTheme.darkTheme,//To be deleted
      appColor: DarkAppColor(),
    ));
    await _saveTheme(true);
  }

  FutureOr<void> _lightTheme(LightThemeEvent event, Emitter<ThemeState> emit) async {
    print('light');

    emit(state.copyWith(
      isDark: false,
      themeData: AppTheme.lightTheme,
      appColor: LightAppColor(),
    ));
    await _saveTheme(false);
  }

  FutureOr<void> _toggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    if (state.isDark) {
      add(LightThemeEvent());
    } else {
      add(DarkThemeEvent());
    }
  }
}
