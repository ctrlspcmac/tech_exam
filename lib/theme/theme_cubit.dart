import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'theme_state.dart';


class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight(message: 'Dark Theme'));

  bool _isDark = true;

  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    if (_isDark) {
      emit(ThemeDark(message: 'Dark Theme'));
    } else {
      emit(ThemeLight(message: 'Light Theme'));
    }
  }
}
