import 'package:flutter/material.dart';

class SettingsService {
  Future<ThemeMode> themeMode() async => ThemeMode.dark;
  Future<Locale> localeMode() async => Locale('en');

  Future<void> updateThemeMode(ThemeMode theme) async {}

  Future<void> updateLocaleMode(Locale locale) async {}
}
