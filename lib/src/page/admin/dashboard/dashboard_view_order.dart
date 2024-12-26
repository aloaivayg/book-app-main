import 'dart:convert';
import 'package:book_app/src/config/data_source/ServerUrl.dart';
import 'package:book_app/src/config/http/http_client.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/model/order.dart';
import 'package:book_app/src/page/admin/dashboard/widget/edit_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  _AdminOrderScreenState createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Order> orderList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    orderList = [];
    fetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> refreshData() async {
    print("refresh");
    await fetchData();

    setState(() {});
  }

  Future<void> fetchData() async {
    final String url = '${ServerUrl.orderApi}/getAllOrders';

    final response = await HttpClient.postRequest(url);

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);

      orderList =
          data.map((json) => Order.fromJson(json)).toList().cast<Order>();
    }
  }

  Future<void> updateOrder(Order order) async {
    print("UPDATING");

    final String url = '${ServerUrl.orderApi}/update';

    var body = {"orderId": order.orderId, "status": order.status.name};

    final response = await HttpClient.postRequest(url, params: body);

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
    }
  }

  List<Order> _filterOrdersByStatus(String status) {
    return orderList
        .where((order) => order.status.name == status.toLowerCase())
        .toList();
  }

  void _showEditDialog(Order order) {
    String selectedStatus = order.status.name;
    final List<String> statuses = [
      'PENDING',
      'PROCESSING',
      'SHIPPED',
      'DELIVERED',
      'CANCELLED'
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Order Status'),
          content: DropdownButtonFormField<String>(
            // value: selectedStatus,
            items: statuses
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedStatus = value!;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  order.status =
                      OrderStatus.getOrderStatusFromString(selectedStatus)!;
                });
                await updateOrder(order);

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteOrder(String orderId) {
    setState(() {
      orderList.removeWhere((order) => order.orderId == orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Orders'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: "Pending"),
            Tab(text: "Processing"),
            Tab(text: "Shipped"),
            Tab(text: "Delivered"),
            Tab(text: "Cancelled"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(_filterOrdersByStatus("PENDING")),
          _buildOrderList(_filterOrdersByStatus("PROCESSING")),
          _buildOrderList(_filterOrdersByStatus("SHIPPED")),
          _buildOrderList(_filterOrdersByStatus("DELIVERED")),
          _buildOrderList(_filterOrdersByStatus("CANCELLED")),
        ],
      ),
      floatingActionButton: ElevatedButton.icon(
          onPressed: (() {
            refreshData();
          }),
          icon: Icon(Icons.refresh),
          label: Text("Refresh")),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Text('No orders available for this status.'),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: ${order.orderId}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('User ID: ${order.userId}'),
                Text('Order Date: ${order.orderDate.toIso8601String()}'),
                Text('Total Amount: \$${order.totalAmount.toStringAsFixed(2)}'),
                Text('Payment Method: ${order.paymentMethod}'),
                Text('Shipping Address: ${order.shippingAddress}'),
                Text('Shipping Method: ${order.shippingMethod}'),
                const SizedBox(height: 8),
                const Text(
                  'Order Items:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ..._buildOrderItems(order.orderItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _showEditDialog(order),
                      child: const Text('Edit'),
                    ),
                    TextButton(
                      onPressed: () => _deleteOrder(order.orderId),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildOrderItems(List<Clothes> items) {
    return items.map<Widget>((item) {
      return ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Image.network(
          item.baseImageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(item.name),
        subtitle: Text('Quantity: ${item.quantity}'),
        trailing: Text('\$${item.price.toStringAsFixed(2)}'),
      );
    }).toList();
  }
}
