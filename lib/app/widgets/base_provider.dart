import 'package:flutter/cupertino.dart';
import 'package:pensol/core/api/api_constant.dart';

/// It's a class that extends ChangeNotifier and has a method called notifyListeners()
class BaseProvider extends ChangeNotifier {
  /// app state
  AppState _appState = AppState.initial;
  AppState _buttonState = AppState.initial;

  /// app state getter
  AppState get appState => _appState;

  /// button state getter
  AppState get buttonState => _buttonState;

  /// app state setter
  void setAppState(AppState appState) {
    _appState = appState;
    notifyListeners();
  }

  /// buttton state setter
  void setButtonState(AppState buttonState) {
    _buttonState = buttonState;
    notifyListeners();
  }
}
