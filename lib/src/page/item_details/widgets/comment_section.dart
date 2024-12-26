import 'package:book_app/src/model/review.dart';
import 'package:book_app/src/page/item_details/widgets/rating_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemDetailCommentSection extends StatefulWidget {
  const ItemDetailCommentSection({Key? key, required this.reviews})
      : super(key: key);

  final List<Review> reviews;

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: const Text(
                "Review and Rating",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),

            // Rating star
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: RatingStars(rating: 4.5),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Review'),
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
                            Text(
                              "camille.officialstore",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.reviews[index].createdAt,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[300]),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            RatingStars(rating: widget.reviews[index].rating),
                            SizedBox(
                              height: 8,
                            ),
                            Text(widget.reviews[index].comment),
                          ],
                        ),
                      );
                    }),
                    separatorBuilder: ((context, index) {
                      return Divider();
                    }),
                    itemCount: widget.reviews.length),
              ),
            )
          ],
        )
      ],
    );
  }
}
