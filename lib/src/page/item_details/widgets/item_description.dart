import 'package:flutter/material.dart';

class DescriptionExpansionTile extends StatefulWidget {
  const DescriptionExpansionTile({Key? key, required this.description})
      : super(key: key);
  final String description;

  @override
  State<DescriptionExpansionTile> createState() =>
      _DescriptionExpansionTileState();
}

class _DescriptionExpansionTileState extends State<DescriptionExpansionTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: const Text(
            "Description",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        ExpansionTile(
          title: Text('Overview'),
          children: <Widget>[
            ListTile(title: Text(widget.description)),
          ],
        ),
        // ExpansionTile(
        //   title: const Text('Material'),
        //   subtitle: const Text('Custom expansion arrow icon'),
        //   trailing: Icon(
        //     _customTileExpanded
        //         ? Icons.arrow_drop_down_circle
        //         : Icons.arrow_drop_down,
        //   ),
        //   children: const <Widget>[
        //     ListTile(title: Text('This is tile number 2')),
        //   ],
        //   onExpansionChanged: (bool expanded) {
        //     setState(() {
        //       _customTileExpanded = expanded;
        //     });
        //   },
        // ),
      ],
    );
  }
}
