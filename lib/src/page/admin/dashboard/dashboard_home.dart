import 'dart:convert';
import 'package:book_app/src/config/data_source/ServerUrl.dart';
import 'package:book_app/src/config/http/http_client.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/page/admin/dashboard/widget/edit_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.onRefresh}) : super(key: key);
  final VoidCallback? onRefresh;
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<Clothes>> _clothesList;

  @override
  void initState() {
    super.initState();
    _clothesList = Clothes.fetchClothes();
    setState(() {});
  }

  Future<void> refreshData() async {
    print("refresh");

    setState(() {
      _clothesList = Clothes.fetchClothes();
    });
  }

  Future<void> deleteClothes(String variantCode) async {
    final String apiUrl = '${ServerUrl.productApi}/delete';
    var body = {"variantCode": variantCode};
    final response = await HttpClient.postRequest(apiUrl, params: body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Deleted product successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Code: ${response.statusCode}. Failed to delete product.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: FutureBuilder<List<Clothes>>(
        future: _clothesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final clothes = snapshot.data![index];
                return buildProductCard(clothes);
              },
            );
          }
        },
      ),
      floatingActionButton: ElevatedButton.icon(
          onPressed: (() {
            refreshData();
          }),
          icon: Icon(Icons.refresh),
          label: Text("Refresh")),
    );
  }

  Widget buildProductCard(Clothes clothes) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Empty Spacer to align buttons to the top-right
                const SizedBox(),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditItemDialog(
                              clothes: clothes,
                              onSave: (updatedClothes) async {
                                // Call the update API or update logic here.

                                setState(() {
                                  _clothesList = Clothes.fetchClothes();
                                });
                              },
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        "Edit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        await deleteClothes(clothes.variantCode);

                        setState(() {
                          _clothesList = Clothes.fetchClothes();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Delete",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16), // Space between buttons and content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                clothes.baseImageUrl.isNotEmpty
                    ? Image.network(
                        clothes.baseImageUrl,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey[300],
                        child: const Center(child: Text("No image available")),
                      ),
                const SizedBox(width: 16), // Space between image and details
                // Product Details Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clothes.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ..._buildDetails(clothes),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDetails(Clothes clothes) {
    final details = {
      "Product Code": clothes.productCode,
      "Description": clothes.description,
      "Price": "\$${clothes.price.toStringAsFixed(2)}",
      "Rating": "${clothes.rating.toString()} / 5",
      "Category": clothes.category,
      "Brand": clothes.brand,
      "Size": clothes.size,
      "Color": clothes.color,
      "Color Hex": clothes.colorHexValue,
      "Quantity": clothes.quantity.toString(),
    };

    return details.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          "${entry.key}: ${entry.value}",
          style: const TextStyle(fontSize: 16),
        ),
      );
    }).toList();
  }
}
