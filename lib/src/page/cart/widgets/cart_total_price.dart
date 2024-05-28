import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartTotalPriceExpansionTile extends StatefulWidget {
  const CartTotalPriceExpansionTile({Key? key, required this.totalPrice})
      : super(key: key);
  final double totalPrice;

  @override
  State<CartTotalPriceExpansionTile> createState() =>
      _CartTotalPriceExpansionTileState();
}

class _CartTotalPriceExpansionTileState
    extends State<CartTotalPriceExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ExpansionTile(
          leading: Container(
              width: Get.width / 2,
              alignment: Alignment.centerLeft,
              child: const Text(
                "Cart Total",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          title: Container(
              width: Get.width / 2,
              alignment: Alignment.centerRight,
              child: Text('\$${widget.totalPrice}')),
          children: <Widget>[
            ListTile(
              leading: Container(
                  width: Get.width / 2,
                  alignment: Alignment.centerLeft,
                  child: Text("Sub Total")),
              title: Container(
                width: Get.width / 2,
                alignment: Alignment.centerRight,
                child: Text(
                  '\$${widget.totalPrice}',
                ),
              ),
            ),
            ListTile(
                leading: Container(
                    width: Get.width / 2,
                    alignment: Alignment.centerLeft,
                    child: Text("Tax included")),
                title: Container(
                  width: Get.width / 2,
                  alignment: Alignment.centerRight,
                  child: Text(
                    '\$0',
                  ),
                )),
          ],
        ),
        const ExpansionTile(
          title: Text('Voucher',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          children: <Widget>[
            ListTile(title: Text('This is tile number 2')),
          ],
        ),
      ],
    );
  }
}
