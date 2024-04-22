import 'package:book_app/src/provider/ClothesProvider.dart';
import 'package:book_app/src/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key, required this.settingsController})
      : super(key: key);
  final SettingsController settingsController;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: myController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 30,
                ),
                hintText: AppLocalizations.of(context)!.searchBarText,
                hintStyle: TextStyle(color: Colors.grey[600])),
            onChanged: (value) {
              context
                  .read<ClothesProvider>()
                  .onSearchClothes(myController.text);
            },
          )),
          IconButton(
              onPressed: () {
                widget.settingsController.updateThemeMode(
                    widget.settingsController.themeMode == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light);
              },
              icon: Icon(
                widget.settingsController.themeMode == ThemeMode.light
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
              )),
          IconButton(
              onPressed: () {
                widget.settingsController.updateLocaleMode(
                    widget.settingsController.localeMode == Locale('en')
                        ? Locale('es')
                        : Locale('en'));
              },
              icon: Icon(
                widget.settingsController.localeMode == const Locale('en')
                    ? Icons.flag
                    : Icons.build,
              ))
        ],
      ),
    );
  }
}
