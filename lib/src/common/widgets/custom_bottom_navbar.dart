import 'package:book_app/src/page/category/category_screen.dart';
import 'package:book_app/src/page/user/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:get/get_navigation/get_navigation.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            circleSize: 45,
            iconSize: 25,
            onTap: () {
              // Navigate to home
            },
          ),
          _buildNavItem(
            icon: Icons.search_outlined,
            iconSize: 30,
            circleSize: 60,
            onTap: () {
              // Navigate to search
              print("CategoryScreen");
              Get.to(const CategoryScreen());
            },
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            iconSize: 25,
            circleSize: 45,
            onTap: () {
              // Navigate to profile
              Get.to(UserProfileScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon,
      required double iconSize,
      required double circleSize,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: circleSize,
        height: circleSize,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: Colors.black,
        ),
      ),
    );
  }
}
