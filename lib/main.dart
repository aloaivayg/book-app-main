import 'package:book_app/src/blocs/clothes_bloc/bloc/clothes_bloc.dart';
import 'package:book_app/src/provider/ClothesProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: ((context) => ClothesBloc()..add(const GetAllClothesEvent()))),
  ], child: MyApp(settingsController: settingsController)));
}
