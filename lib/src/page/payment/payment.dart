import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/page/payment/widgets/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        leading: GestureDetector(
          child: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: const Color.fromARGB(255, 254, 252, 252),
            onPressed: () {
              context.read<ClothesBloc>().add(const ViewCartEvent());
              Get.back();
            },
          ),
        ),
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
  List<String> cards = ["COD", "Online banking", "Momo"];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClothesBloc, ClothesState>(
      builder: (context, state) {
        if (state is ViewPaymentDetailSuccess) {
          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: Get.height * 0.78,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            width: double.maxFinite,
                            // height: 160,
                            margin: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white60,
                                    blurRadius: 1.0,
                                    spreadRadius: 0.0,
                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(
                                        0, 2), // shadow direction: bottom right
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
                        ),
                        Flexible(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white60,
                                    blurRadius: 1.0,
                                    spreadRadius: 0.0,
                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(
                                        0, 2), // shadow direction: bottom right
                                  )
                                ]),
                            // height: 190,
                            width: double.maxFinite,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Payment method",
                                          style: TextStyle(fontSize: 16)),
                                      Text("See all"),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  width: double.maxFinite,
                                  child: const PaymentOptions(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 20, right: 20),
                            height: 200,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white60,
                                    blurRadius: 1.0,
                                    spreadRadius: 0.0,
                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(
                                        0, 2), // shadow direction: bottom right
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Payment details",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Sub total:"),
                                    Text("\$${state.totalPrice}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Shipping fee: "),
                                    Text("\$"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Discount: "),
                                    Text("\$"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Total:"),
                                    Text("\$${state.totalPrice}"),
                                  ],
                                ),
                              ],
                            ),
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
        return SizedBox();
      },
    );
  }
}
