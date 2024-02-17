import 'package:book_app/src/provider/BookProvider.dart';
import 'package:book_app/src/provider/ClothesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => BookProvider())),
    ChangeNotifierProvider(create: ((context) => ClothesProvider())),
  ], child: MyApp(settingsController: settingsController)));
}
