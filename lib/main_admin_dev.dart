import 'package:book_app/flavor.dart';
import 'package:book_app/src/blocs/app_setting_bloc/bloc/app_setting_bloc.dart';
import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:book_app/src/page/admin/dashboard/dashboard.dart';
import 'package:book_app/src/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  F.appFlavor = Flavor.ADMIN_DEV;

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

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          routes: {'/dashboard': (context) => const DashboardScreen()},

          debugShowCheckedModeBanner: false,

          //set locale
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('vi', ''),
            Locale('en', ''),
          ],
          locale: settingsController.localeMode,
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: Themes.lightTheme,
          darkTheme: Themes.lightTheme,
          themeMode: settingsController.themeMode,
          initialRoute: '/dashboard',
          routingCallback: (routing) {
            print(routing!.current);
          },
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);

                  default:
                    return const DashboardScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
