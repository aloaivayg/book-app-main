import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../common/widgets/custom_button.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          SizedBox(
            width: 40,
          )
        ],
        title: Container(
            alignment: Alignment.center,
            width: Get.width,
            child: const Text("Payment")),
      ),
      body: const PaymentDetails(),
    );
  }
}

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  List<String> cards = ["COD", "Online banking", "Pay pal"];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: Get.height * 0.78,
              child: ListView(
                children: [
                  Container(
                    width: double.maxFinite,
                    // height: 150,
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    decoration:
                        const BoxDecoration(color: Colors.black, boxShadow: [
                      BoxShadow(
                        color: Colors.white60,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(0, 2), // shadow direction: bottom right
                      )
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Delivery address",
                            style: TextStyle(fontSize: 16)),
                        TextField(
                          maxLines: 4,
                          decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          controller: TextEditingController()
                            ..text =
                                "124, Nam Ky Khoi Nghia, Thu Dau Mot city, Binh Duong",
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    decoration:
                        const BoxDecoration(color: Colors.black, boxShadow: [
                      BoxShadow(
                        color: Colors.white60,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(0, 2), // shadow direction: bottom right
                      )
                    ]),
                    // height: 190,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Payment method",
                                  style: TextStyle(fontSize: 16)),
                              Text("See all"),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          width: double.maxFinite,
                          child: ListView.builder(
                              itemCount: cards.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  width: double.maxFinite,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.payment),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          width: 180,
                                          margin:
                                              const EdgeInsets.only(left: 50),
                                          child: Text(cards[index])),
                                      index == 0
                                          ? Container(
                                              alignment: Alignment.centerRight,
                                              child: const Icon(
                                                  Icons.radio_button_checked))
                                          : Container(
                                              child:
                                                  Icon(Icons.radio_button_off))
                                    ],
                                  ),
                                );
                              })),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    // height: 200,
                    decoration:
                        const BoxDecoration(color: Colors.black, boxShadow: [
                      BoxShadow(
                        color: Colors.white60,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(0, 2), // shadow direction: bottom right
                      )
                    ]),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Apply voucher",
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(Icons.discount)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sub total: "),
                            Text("\$"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shipping fee: "),
                            Text("\$"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Discount: "),
                            Text("\$"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total: "),
                            Text("\$"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(top: 15, bottom: 20),
                child: const SquareButton(
                  height: 40,
                  width: 300,
                  text: "Place order",
                  color: Colors.black,
                  textColor: Colors.white,
                  borderRadius: 14,
                ),
              ),
            ),
          ],
        ));
  }
}
