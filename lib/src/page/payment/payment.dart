import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/page/order/order_info_screen.dart';
import 'package:book_app/src/page/order/order_screen.dart';
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
  List<Map<String, String>> paymentOption = [
    {"title": "COD", "subtitle": "Pay on receipt "},
    {"title": "Online banking", "subtitle": "Pay through online banking app"},
    {"title": "Momo", "subtitle": "Pay through Momo wallet"},
  ];
  List<Map<String, String>> deliveryOption = [
    {"title": "Fast Delivery", "subtitle": "10\$"},
    {"title": "Standard Delivery", "subtitle": "5\$"},
  ];

  late TextEditingController addressController;
  late FocusNode addressFocusNode;
  late ClothesBloc clothesBloc;
  late UserBloc userBloc;

  final Map<String, String> formData = {
    "userId": "",
    "shippingAddress": "124, Nam Ky Khoi Nghia, Thu Dau Mot city, Binh Duong",
    "paymentMethod": "",
    "shippingMethod": "",
  };

  @override
  void initState() {
    super.initState();
    clothesBloc = context.read<ClothesBloc>();
    userBloc = context.read<UserBloc>();

    addressController = TextEditingController(
        text: '124, Nam Ky Khoi Nghia, Thu Dau Mot city, Binh Duong');
    addressFocusNode = FocusNode();

    if (userBloc.user != null) {
      formData["userId"] = userBloc.user!.id;
    }
  }

  bool isReadOnly = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClothesBloc, ClothesState>(
      builder: (context, state) {
        if (state is ViewPaymentDetailSuccess) {
          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    // height: Get.height * 0.78,
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
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white60,
                                    blurRadius: 1.0,
                                    spreadRadius: 0.0,
                                    blurStyle: BlurStyle.outer,
                                    offset: Offset(
                                        0, 2), // shadow direction: bottom right
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Delivery Address',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isReadOnly = false;
                                            addressFocusNode.requestFocus();
                                          });
                                        },
                                        child: Container(
                                          child: const Text(
                                            'Change',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    // textInputAction: TextInputAction.continueAction,
                                    keyboardType: TextInputType.text,
                                    readOnly: isReadOnly,
                                    focusNode: addressFocusNode,
                                    controller: addressController,
                                    onEditingComplete: () {
                                      isReadOnly = true;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        formData["shippingAddress"] = value;
                                      });
                                    },
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
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
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
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
                                  height: 200,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  width: double.maxFinite,
                                  child: CardOptions(
                                    options: paymentOption,
                                    onCardSelected: (String value) {
                                      setState(() {
                                        formData["paymentMethod"] = value;
                                      });
                                    },
                                  ),
                                ),
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
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
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
                                      Text("Delivery method",
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 160,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  width: double.maxFinite,
                                  child: CardOptions(
                                    options: deliveryOption,
                                    onCardSelected: (String value) {
                                      setState(() {
                                        formData["shippingMethod"] = value;
                                      });
                                    },
                                  ),
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
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(10),
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
                                    Text("VAT included: "),
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
                    onTap: () {
                      clothesBloc.add(PlaceOrderEvent(formData: formData));
                    },
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
        return const SizedBox();
      },
      listener: (BuildContext context, ClothesState state) {
        if (state is PlaceOrderSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Place order success")),
          );
          Get.off(OrderInfoScreen());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Place order error")),
          );
        }
      },
    );
  }
}
