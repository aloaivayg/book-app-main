import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/common/widgets/custom_appbar.dart';
import 'package:book_app/src/common/widgets/custom_bottom_navbar.dart';
import 'package:book_app/src/page/order/order_screen.dart';
import 'package:book_app/src/page/order/widgets/order_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class OrderInfoScreen extends StatefulWidget {
  const OrderInfoScreen({super.key});

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Order Information"),
        body: OrderInfoScreenDetails(),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}

class OrderInfoScreenDetails extends StatefulWidget {
  const OrderInfoScreenDetails({super.key});

  @override
  State<OrderInfoScreenDetails> createState() => _OrderInfoScreenDetailsState();
}

class _OrderInfoScreenDetailsState extends State<OrderInfoScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ClothesBloc, ClothesState>(
        builder: (context, state) {
          if (state is PlaceOrderSuccess) {
            return Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(66, 248, 242, 242),
                ),
                child: Column(
                  children: [
                    // order tabs
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Text("Order infomation details"),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  state.order.status.name.toUpperCase(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 72, 199, 125)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  state.order.orderDate.toIso8601String(),
                                  style: TextStyle(color: Colors.grey[200]),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Container(
                          alignment: Alignment.center,
                          child: Container(
                            width: Get.width,
                            child: Column(children: [
                              // title
                              Container(),

                              // product
                              ...state.order.orderItems
                                  .map(
                                    (item) => Container(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // image
                                          Container(
                                            width: 80,
                                            height: 80,
                                            child: Image.network(
                                                item.baseImageUrl),
                                          ),
                                          // details
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                // name
                                                Text(
                                                  item.name,
                                                  style: TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis),
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
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                  "Total price: \$${state.order.totalAmount.toString()}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                          )),
                    )
                  ],
                ));
          }
          return Container();
        },
      ),
    );
  }
}
