import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemDetailCommentSection extends StatefulWidget {
  const ItemDetailCommentSection({Key? key, required this.commentDetail})
      : super(key: key);

  final List<String> commentDetail;

  @override
  State<ItemDetailCommentSection> createState() =>
      _ItemDetailCommentSectionState();
}

class _ItemDetailCommentSectionState extends State<ItemDetailCommentSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name 1"),
                  Text("Date 1"),
                  FaIcon(
                    FontAwesomeIcons.star,
                    size: 10,
                  ),
                  Text("Content"),
                ],
              ),
            );
          }),
          separatorBuilder: ((context, index) {
            return Divider();
          }),
          itemCount: 3),
    );
  }
}
