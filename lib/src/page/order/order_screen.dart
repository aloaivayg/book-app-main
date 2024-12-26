import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/common/widgets/custom_appbar.dart';
import 'package:book_app/src/common/widgets/custom_bottom_navbar.dart';
import 'package:book_app/src/model/order.dart';
import 'package:book_app/src/page/order/widgets/order_card.dart';
import 'package:book_app/src/page/user/login/login.dart';
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
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _controller = AnimationController(vsync: this);
    userBloc = context.read<UserBloc>();
    clothesBloc = context.read<ClothesBloc>();

    if (userBloc.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        clothesBloc.add(ViewAllOrdersEvent(userId: userBloc.user!.id));
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.off(LoginScreen());
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();

    super.dispose();
  }

  List<Order> _filterOrdersByStatus(String status, List<Order> orderList) {
    return orderList
        .where((order) => order.status.name == status.toLowerCase())
        .toList();
  }

  Widget _buildOrderList(List<Order> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Text('Nothing here.'),
      );
    }

    return Container(
      alignment: Alignment.center,
      height: Get.height,
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) => OrderCard(order: orders[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Tab(text: "Processing"),
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
                      _buildOrderList(
                          _filterOrdersByStatus("PENDING", state.orderList)),
                      _buildOrderList(
                          _filterOrdersByStatus("PROCESSING", state.orderList)),
                      _buildOrderList(
                          _filterOrdersByStatus("SHIPPED", state.orderList)),
                      _buildOrderList(
                          _filterOrdersByStatus("DELIVERED", state.orderList)),
                      _buildOrderList(
                          _filterOrdersByStatus("CANCELLED", state.orderList)),
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
