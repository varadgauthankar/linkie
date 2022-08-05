import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  final String _key = 'themeMode';

  ThemeProvider() {
    _getThemeFromPrefs();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    _saveThemeToPrefs();
    notifyListeners();
  }

  void _getThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeFromPrefs = ThemeMode.values[prefs.getInt(_key) ?? 1];
    _themeMode = themeFromPrefs;
    notifyListeners();
  }

  void _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_key, themeMode.index);
  }
}
