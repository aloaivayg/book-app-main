import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/common/widgets/custom_appbar.dart';
import 'package:book_app/src/common/widgets/custom_bottom_navbar.dart';
import 'package:book_app/src/page/order/widgets/order_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: "Order"),
        body: OrderScreenDetails(),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}

class OrderScreenDetails extends StatefulWidget {
  const OrderScreenDetails({super.key});

  @override
  State<OrderScreenDetails> createState() => _OrderScreenDetailsState();
}

class _OrderScreenDetailsState extends State<OrderScreenDetails>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late final TabController _tabController;

  late ClothesBloc clothesBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _controller = AnimationController(vsync: this);
    clothesBloc = context.read<ClothesBloc>();
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    clothesBloc.add(ViewAllOrdersEvent(userId: "user123"));
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          // order tabs
          Container(
            height: Get.height * 0.1,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(
                  text: "Pending",
                ),
                Tab(text: "Shipping"),
                Tab(text: "Shipped"),
                Tab(text: "Delivered"),
                Tab(text: "Cancelled"),
              ],
            ),
          ),
          // tab details
          // show a placehold when empty
          BlocBuilder<ClothesBloc, ClothesState>(
            builder: (context, state) {
              if (state is ViewAllOrdersSuccess) {
                return Container(
                  height: Get.height * 0.7,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: Get.height,
                        child: ListView.builder(
                          itemCount: state.orderList.length,
                          itemBuilder: (context, index) =>
                              OrderCard(order: state.orderList[index]),
                        ),
                      ),
                      Container(
                        height: Get.height,
                        color: Colors.blue,
                      ),
                      Container(
                        height: Get.height,
                        color: Colors.white,
                      ),
                      Container(
                        height: Get.height,
                        color: Colors.green,
                      ),
                      Container(
                        height: Get.height,
                        color: Colors.pink[100],
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      )),
    );
  }
}
