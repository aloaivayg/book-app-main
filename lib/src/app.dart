import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/page/cart/cart.dart';
import 'package:book_app/src/page/home/home.dart';
import 'package:book_app/src/page/item_details/item_details.dart';
import 'package:book_app/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

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
          routes: {
            '/': (context) => HomePage(settingsController: settingsController),
            // '/item': (context) => const ItemInfoPage()
          },

          debugShowCheckedModeBanner: false,

          //set locale
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
          locale: settingsController.localeMode,
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: settingsController.themeMode,
          initialRoute: '/',
          routingCallback: (routing) {
            print(routing!.current);

            if (routing.current == "/") {
              print("CALLING BACK");
              context.read<ClothesBloc>().add(const GetAllClothesEvent());
            }
          },
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);

                  default:
                    return HomePage(settingsController: settingsController);
                }
              },
            );
          },
        );
      },
    );
  }
}
