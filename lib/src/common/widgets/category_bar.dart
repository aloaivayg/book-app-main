import 'package:book_app/src/model/category.dart';
import 'package:book_app/src/page/shopping/shopping_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

class CategoryGrid extends StatefulWidget {
  final List<Category> categories;

  const CategoryGrid({Key? key, required this.categories}) : super(key: key);

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
            controller: _tabController,
            tabs: widget.categories.map((element) {
              return Tab(
                text: element.title,
              );
            }).toList()),
        Flexible(
          child: Container(
            child: TabBarView(
                controller: _tabController,
                children: widget.categories
                    .map(
                      (e) => GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: e.subcategories
                            .length, // Show subcategories for the first category
                        itemBuilder: (context, index) {
                          final subcategory = e.subcategories[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(ShoppingScreen());
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Subcategory Image
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "http://localhost:8080/uploads/DG_T-Shirt_white.png",
                                      fit: BoxFit.cover,
                                      height: 50,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Subcategory Label
                                Text(
                                  subcategory.label,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                    .toList()),
          ),
        ),
      ],
    );
  }
}
