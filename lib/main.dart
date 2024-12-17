import 'dart:async';

import 'package:book_app/src/blocs/app_setting_bloc/bloc/app_setting_bloc.dart';
import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/configuration/environment/build_config.dart';
import 'package:book_app/src/configuration/environment/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

// void main() async {
//   final settingsController = SettingsController(SettingsService());

//   await settingsController.loadSettings();

//   runApp(MultiBlocProvider(
//       providers: [
//         BlocProvider(
//             create: ((context) => AppSettingBloc()
//               ..add(AppSettingInitialEvent(
//                   settingsController: settingsController)))),
//         BlocProvider(create: ((context) => ClothesBloc())),
//         BlocProvider(create: ((context) => UserBloc())),
//       ],
//       child: MyApp(
//         settingsController: settingsController,
//       )));
// }
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const env = String.fromEnvironment('env', defaultValue: CustomEnv.clientDev);
late SettingsController settingsController;

main() async {
  settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  SetupEnv();
}

class SetupEnv extends Env {
  @override
  Future? onInjection() async {}

  @override
  FutureOr<void> onCreate() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget onCreateView() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return Container(color: Colors.green);
    };
    return Container();
  }
}
