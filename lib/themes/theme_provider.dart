import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //current theme
  ThemeMode _theme = ThemeMode.light;

  //get theme
  ThemeMode get theme => _theme;

  //change theme
  void toggleTheme() {
    if (_theme == ThemeMode.light) {
      _theme = ThemeMode.dark;
    } else {
      _theme = ThemeMode.light;
    }

    notifyListeners();
  }
}
