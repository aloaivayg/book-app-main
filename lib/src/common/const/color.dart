import 'package:book_app/src/util/color_from_hex.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppColor {
  static const Color red = Color.fromARGB(229, 230, 80, 80);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const blueBlack = Color.fromARGB(255, 41, 46, 48);
  static var lightPink = HexColor.fromHex("#EA1E63");
}

class Styles {
  static const TextStyle categoryTitle =
      TextStyle(fontSize: 30, color: AppColor.black);
}
