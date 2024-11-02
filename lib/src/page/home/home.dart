import 'package:book_app/src/blocs/app_setting_bloc/bloc/app_setting_bloc.dart';
import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/page/home/widget/coming_clothes.dart';
import 'package:book_app/src/page/home/widget/custom_app_bar.dart';
import 'package:book_app/src/page/home/widget/custom_button.dart';
import 'package:book_app/src/page/home/widget/recommended_item.dart';
import 'package:book_app/src/page/home/widget/trending_clothes.dart';
import 'package:book_app/src/page/user/login.dart';
import 'package:book_app/src/page/user/user_profile_screen.dart';
import 'package:book_app/src/provider/ClothesProvider.dart';
import 'package:book_app/src/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  // final SettingsController? settingsController;
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appTitle)),
      body: HomePageDetail(),
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserProfileScreen()));
              }),
              child: const Icon(Icons.person_outline)),
        )
      ],
    );
  }
}

class HomePageDetail extends StatefulWidget {
  const HomePageDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageDetail> createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail> {
  final dataKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingBloc, AppSettingState>(
      builder: (context, state) {
        if (state is AppSettingInitialSuccess) {
          return SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CustomAppBar(settingsController: state.settingsController!),
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
        return Container();
      },
    );
  }
}
