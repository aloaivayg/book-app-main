import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({Key? key}) : super(key: key);

  @override
  PaymentOptionsState createState() => PaymentOptionsState();
}

class PaymentOptionsState extends State<PaymentOptions> {
  List<String> cards = ["COD", "Online banking", "Momo"];
  String? selectedCard;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: cards.map((card) {
        return RadioListTile<String>(
          visualDensity: VisualDensity.comfortable,
          title: Container(
              padding: const EdgeInsets.only(left: 15), child: Text(card)),
          controlAffinity: ListTileControlAffinity.trailing,
          secondary: Container(
            // alignment: Alignment.centerLeft,
            child: const Icon(Icons.payment),
          ),
          value: card,
          groupValue: selectedCard,
          onChanged: (String? value) {
            setState(() {
              selectedCard = value;
            });
          },
        );
      }).toList(),
    );
  }
}
