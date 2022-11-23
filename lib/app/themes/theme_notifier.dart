import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier{

  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  ThemeChanger(){
    getStoredTheme();
  }

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  getStoredTheme() async {
    _darkTheme = await darkThemePreference.getTheme();
    notifyListeners();
  }
}


class DarkThemePreference {
  static const themeStatus = "themeStatus";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
    
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}