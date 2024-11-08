import 'package:book_app/src/blocs/app_setting_bloc/bloc/app_setting_bloc.dart';
import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: ((context) => AppSettingBloc()
              ..add(AppSettingInitialEvent(
                  settingsController: settingsController)))),
        BlocProvider(create: ((context) => ClothesBloc())),
        BlocProvider(create: ((context) => UserBloc())),
      ],
      child: MyApp(
        settingsController: settingsController,
      )));
}
