import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/page/cart/cart.dart';
import 'package:book_app/src/page/order/order_screen.dart';
import 'package:book_app/src/page/user/login/login.dart';
import 'package:book_app/src/page/user/profile/user_profile_screen.dart';
import 'package:book_app/src/util/color_from_hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserMenuScreen extends StatefulWidget {
  const UserMenuScreen({Key? key}) : super(key: key);

  @override
  State<UserMenuScreen> createState() => _UserMenuScreenState();
}

class _UserMenuScreenState extends State<UserMenuScreen> {
  late UserBloc userBloc;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.userBloc.isSignedIn) {
    //   return const UserProfileScreenDetail();
    // } else {
    //   return const LoginScreen();
    // }
    return const UserMenuScreenDetail();
  }
}

class UserMenuScreenDetail extends StatefulWidget {
  const UserMenuScreenDetail({Key? key}) : super(key: key);

  @override
  _UserMenuScreenDetailState createState() => _UserMenuScreenDetailState();
}

class _UserMenuScreenDetailState extends State<UserMenuScreenDetail> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              AppLocalizations.of(context)!.member,
              // style: const TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: Color.fromARGB(255, 254, 252, 252),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: const Color.fromARGB(255, 254, 252, 252),
                ),
                onPressed: () {},
              ),
              Stack(children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.cartShopping),
                  onPressed: () {
                    context.read<ClothesBloc>().add(const ViewCartEvent());
                    Get.off(const CartPage());
                  },
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(context
                            .read<ClothesBloc>()
                            .cartItems
                            .length
                            .toString())),
                  ),
                )
              ]),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: 50,
                        child: Text(AppLocalizations.of(context)!.memberCode),
                      ),
                      SizedBox(height: 20),
                      Container(
                          width: 200,
                          height: 200,
                          color: Colors.white,
                          child: QrImageView(
                            data: "avc",
                            version: QrVersions.auto,
                          )),
                      SizedBox(height: 20),
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.to(LoginScreen());
                      //   },
                      //   child: Container(
                      //     width: 150,
                      //     height: 30,
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         color: HexColor.fromHex("9C28B1"),
                      //         borderRadius: BorderRadius.circular(8)),
                      //     child: const Text("Sign in"),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildGridItem(
                      Icons.person,
                      AppLocalizations.of(context)!.profile,
                      () {
                        var user = context.read<UserBloc>().user;
                        if (user != null) {
                          Get.to(const UserProfileScreen());
                        } else {
                          Get.to(const LoginScreen());
                        }
                      },
                    ),
                    _buildGridItem(Icons.history,
                        AppLocalizations.of(context)!.transaction, () => {}),
                    _buildGridItem(Icons.discount,
                        AppLocalizations.of(context)!.vouchers, () => {}),
                    _buildGridItem(Icons.card_travel, "My order",
                        () => Get.to(const OrderScreen())),
                    _buildGridItem(Icons.settings,
                        AppLocalizations.of(context)!.settings, () => {}),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        // if (state.user == null) {
        //   // If user is logged out, navigate to LoginScreen
        //   Get.to(const LoginScreen());
        // }
      },
    );
  }

  Widget _buildGridItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
