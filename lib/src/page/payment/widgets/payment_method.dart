import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardOptions extends StatefulWidget {
  const CardOptions({
    Key? key,
    required this.options,
    this.subtitles,
    required this.onCardSelected, // Add a callback for selection change
  }) : super(key: key);

  final List<Map<String, String>> options;
  final List<Map<String, String>>? subtitles;
  final Function(String) onCardSelected; // Callback function

  @override
  CardOptionsState createState() => CardOptionsState();
}

class CardOptionsState extends State<CardOptions> {
  String? selectedCard;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.options.map((card) {
        return RadioListTile<String>(
          visualDensity: VisualDensity.comfortable,
          title: Container(
            padding: const EdgeInsets.only(left: 15),
            child: Text(card["title"]!),
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          subtitle: Container(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              card["subtitle"]!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          secondary: const Icon(Icons.payment),
          value: card["title"]!,
          groupValue: selectedCard,
          onChanged: (String? value) {
            setState(() {
              selectedCard = value;
              if (value != null) {
                widget.onCardSelected(value); // Notify the parent widget
              }
            });
          },
        );
      }).toList(),
    );
  }
}
