import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void openAnimatedDialog(
    BuildContext context, String message, VoidCallback onClose) {
  showGeneralDialog(
      context: context,
      pageBuilder: ((context, animation, secondaryAnimation) {
        return Container();
      }),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: ((context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
            child: AlertDialog(
              title: Center(child: Text(message)),
              actions: [
                TextButton(
                  child: const Text("Confirm"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onClose();
                  },
                ),
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onClose();
                  },
                ),
              ],
            ),
          ),
        );
      }));
}

class UserDialog extends StatelessWidget {
  const UserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Item Added to Cart"),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("You have successfully added the item to your cart."),
          SizedBox(height: 20),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Continue Shopping"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Go to Cart"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
