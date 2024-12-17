import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/page/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late ClothesBloc clothesBloc;

  @override
  void initState() {
    super.initState();
    clothesBloc = context.read<ClothesBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none,
            color: Color.fromARGB(255, 254, 252, 252),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.favorite_border,
            color: const Color.fromARGB(255, 254, 252, 252),
          ),
          onPressed: () {},
        ),
        Stack(children: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.cartShopping),
            onPressed: () {
              clothesBloc.add(const ViewCartEvent());
              Get.to(const CartPage());
            },
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child:
                  Center(child: Text(clothesBloc.cartItems.length.toString())),
            ),
          )
        ]),
      ],
    );
  }
}
