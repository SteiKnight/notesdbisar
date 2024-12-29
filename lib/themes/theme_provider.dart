import 'package:flutter/material.dart';
import 'package:notesdbisar/themes/theme.dart';

class ThemeProvider extends ChangeNotifier {
  //current theme
  ThemeData _theme = lightMode;

  //get theme
  ThemeData get theme => _theme;

  //check to see if in dark mode
  bool get isDarkMode => _theme == darkMode;

  //setter method for theme
  set theme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }

  //change theme
  void toggleTheme() {
    if (_theme == lightMode) {
      _theme = darkMode;
    } else {
      _theme = lightMode;
    }

    notifyListeners();
  }
}
