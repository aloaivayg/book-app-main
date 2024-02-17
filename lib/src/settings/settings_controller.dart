import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  late ThemeMode _themeMode;

  late Locale _locale;

  ThemeMode get themeMode => _themeMode;
  Locale get localeMode => _locale;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _locale = await _settingsService.localeMode();
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateLocaleMode(Locale? newLocaleMode) async {
    if (newLocaleMode == null) return;

    if (newLocaleMode == _locale) return;

    _locale = newLocaleMode;

    notifyListeners();

    await _settingsService.updateLocaleMode(newLocaleMode);
  }
}
