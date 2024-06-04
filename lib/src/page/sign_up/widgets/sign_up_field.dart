import 'package:book_app/src/util/color_from_hex.dart';
import 'package:flutter/material.dart';

class SignUpField extends StatefulWidget {
  const SignUpField(
      {Key? key,
      required this.text,
      required this.icon,
      required this.controller,
      this.keyboardType})
      : super(key: key);
  final String text;
  final Widget icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  @override
  State<SignUpField> createState() => _SignUpFieldState();
}

class _SignUpFieldState extends State<SignUpField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: Get.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
          color: HexColor.fromHex("#EA1E63"),
          borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        obscureText:
            widget.keyboardType == TextInputType.visiblePassword ? true : false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: widget.text,
            icon: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: widget.icon)),
      ),
    );
  }
}
