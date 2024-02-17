import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomSortTitle extends StatefulWidget {
  const CustomSortTitle({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<CustomSortTitle> createState() => _CustomSortTitleState();
}

class _CustomSortTitleState extends State<CustomSortTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 30,
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 20, left: 20),
      child: Container(
        width: 70,
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(),
            color: Colors.black,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
