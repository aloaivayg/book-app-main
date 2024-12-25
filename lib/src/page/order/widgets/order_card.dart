import 'package:book_app/src/model/order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromARGB(66, 248, 242, 242),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        // title
        Container(),

        // product
        ...widget.order.orderItems
            .map(
              (item) => Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // image
                    Container(
                      width: 80,
                      height: 80,
                      child: Image.network(item.baseImageUrl),
                    ),
                    // details
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // name
                          Text(
                            item.name,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                          // quantity
                          Text(
                            "x${item.quantity.toString()}",
                            style: TextStyle(),
                          ),
                          // price
                          Text(
                            "Item price: \$${item.price.toString()}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),

        Container(
          width: Get.width,
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(bottom: 8),
          child: Text(
            "Total price: \$${widget.order.totalAmount.toString()}",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        // button
        Container(
          alignment: Alignment.centerRight,
          width: Get.width,
          child: GestureDetector(
            child: SizedBox(
                width: 80,
                height: 40,
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black),
                    child: Text(
                      "View details",
                      style: TextStyle(fontSize: 12),
                    ))),
          ),
        ),
      ]),
    );
  }
}
