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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text(
            "Review and Rating",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        ExpansionTile(
          title: Text('Comment'),
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("camille.officialstore"),
                            Text("2023-08-24"),
                            FaIcon(
                              FontAwesomeIcons.star,
                              size: 10,
                            ),
                            Text(
                                "Sweater kiểu này đẹp quá, có phối layer kiểu basic rất dễ phối đồ mà nam nữ đều ok nè..."),
                          ],
                        ),
                      );
                    }),
                    separatorBuilder: ((context, index) {
                      return Divider();
                    }),
                    itemCount: 3),
              ),
            )
          ],
        )
      ],
    );
  }
}
