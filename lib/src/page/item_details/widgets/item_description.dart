import 'package:flutter/material.dart';

class DescriptionExpansionTile extends StatefulWidget {
  const DescriptionExpansionTile({Key? key}) : super(key: key);

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
            style: TextStyle(color: Colors.white),
          ),
        ),
        const ExpansionTile(
          title: Text('Overview'),
          subtitle: Text('Trailing expansion arrow icon'),
          children: <Widget>[
            ListTile(title: Text('This is tile number 1')),
          ],
        ),
        ExpansionTile(
          title: const Text('Material'),
          subtitle: const Text('Custom expansion arrow icon'),
          trailing: Icon(
            _customTileExpanded
                ? Icons.arrow_drop_down_circle
                : Icons.arrow_drop_down,
          ),
          children: const <Widget>[
            ListTile(title: Text('This is tile number 2')),
          ],
          onExpansionChanged: (bool expanded) {
            setState(() {
              _customTileExpanded = expanded;
            });
          },
        ),
      ],
    );
  }
}
