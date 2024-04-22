import 'package:book_app/src/page/home/widget/coming_clothes.dart';
import 'package:book_app/src/page/home/widget/custom_app_bar.dart';
import 'package:book_app/src/page/home/widget/custom_button.dart';
import 'package:book_app/src/page/home/widget/recommended_item.dart';
import 'package:book_app/src/page/home/widget/trending_clothes.dart';
import 'package:book_app/src/page/login/login.dart';
import 'package:book_app/src/provider/ClothesProvider.dart';
import 'package:book_app/src/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  final SettingsController? settingsController;
  const HomePage({Key? key, required this.settingsController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appTitle)),
      body: HomePageDetail(
        settingsController: settingsController,
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    ));
  }

  BottomNavigationBar _buildBottomNavigation(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Color(0xFF6741FF),
      items: [
        const BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_rounded),
        ),
        const BottomNavigationBarItem(
          label: 'Column',
          icon: Icon(Icons.view_week_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Person',
          icon: InkWell(
              onTap: (() {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }),
              child: const Icon(Icons.person_outline)),
        )
      ],
    );
  }
}

class HomePageDetail extends StatelessWidget {
  final SettingsController? settingsController;

  HomePageDetail({Key? key, required this.settingsController})
      : super(key: key);

  final dataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CustomAppBar(settingsController: settingsController!),
          // Row(
          //   children: [
          //     InkWell(
          //       child: const CustomSortTitle(
          //         title: "Trending",
          //       ),
          //       onTap: () => Scrollable.ensureVisible(
          //           dataKey.currentContext!,
          //           duration: const Duration(seconds: 2)),
          //     ),
          //     InkWell(
          //         child: const CustomSortTitle(
          //           title: "By Price",
          //         ),
          //         onTap: () {
          //           context.read<ClothesProvider>().onSortPrice();
          //           Scrollable.ensureVisible(dataKey.currentContext!,
          //               duration: const Duration(seconds: 2));
          //         }),
          //     InkWell(
          //         child: const CustomSortTitle(
          //           title: "By Star",
          //         ),
          //         onTap: () {
          //           context.read<ClothesProvider>().onSortStar();
          //           Scrollable.ensureVisible(dataKey.currentContext!,
          //               duration: const Duration(seconds: 2));
          //         }),
          //   ],
          // ),

          ComingClothes(),
          const RecommendedItem(),
          TrendingClothes(
            key: dataKey,
          ),
        ],
      ),
    );
  }
}
