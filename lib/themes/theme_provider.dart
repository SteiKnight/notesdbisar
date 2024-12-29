import 'package:flutter/material.dart';
import 'package:notesdbisar/themes/theme.dart';

class ThemeProvider extends ChangeNotifier {
  //current theme
  ThemeData _theme = lightMode;

  //get theme
  ThemeData get theme => _theme;

  //change theme
  void toggleTheme() {
    if (_theme == ThemeMode.light) {
      _theme = darkMode;
    } else {
      _theme = lightMode;
    }

    notifyListeners();
  }
}
