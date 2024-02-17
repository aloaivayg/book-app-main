import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SquareButton extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;
  final String text;
  const SquareButton(
      {Key? key,
      required this.height,
      required this.width,
      this.color = Colors.white,
      this.textColor = Colors.black,
      this.borderWidth = 1,
      this.borderRadius = 8,
      required this.text,
      this.borderColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: borderWidth)),
      height: height,
      width: width,
      child: Align(
          child: Text(
        text,
        style: TextStyle(color: textColor),
      )),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({key, this.onPressed});
  final void onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Ink(
            decoration: const ShapeDecoration(
              color: Colors.blue,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_rounded),
              color: Colors.black,
              onPressed: () => onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
