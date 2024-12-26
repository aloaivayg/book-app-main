import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/common/widgets/custom_appbar.dart';
import 'package:book_app/src/common/widgets/custom_bottom_navbar.dart';
import 'package:book_app/src/common/widgets/filter_chip.dart';
import 'package:book_app/src/page/item_details/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: ""),
        body: ShoppingScreenDetails(),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }
}

class ShoppingScreenDetails extends StatefulWidget {
  const ShoppingScreenDetails({Key? key}) : super(key: key);

  @override
  State<ShoppingScreenDetails> createState() => _ShoppingScreenDetailsState();
}

class _ShoppingScreenDetailsState extends State<ShoppingScreenDetails> {
  late ClothesBloc clothesBloc;

  @override
  void initState() {
    super.initState();
    clothesBloc = context.read<ClothesBloc>();
  }

  @override
  Widget build(BuildContext context) {
    var clothesList = clothesBloc.itemListByProductCode;

    return SingleChildScrollView(
      child: Container(
        height: Get.height * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8.0),
            Container(
              width: Get.width,
              child: const FilterDropdowns(
                  filterOptions: ["Size", "Color", "Price"]),
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Container(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: clothesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        clothesBloc.add(
                            ViewClothesInfoEvent(clothes: clothesList[index]));
                        Get.to(ItemInfoPage());
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      clothesList[index].baseImageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),

                                // Product colors
                                Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.grey.shade400,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor:
                                          Color.fromARGB(255, 45, 157, 202),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor:
                                          Color.fromARGB(255, 180, 235, 61),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FaIcon(FontAwesomeIcons.heart)
                                ]),

                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    clothesList[index].name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "\$${clothesList[index].price.toString()}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  children: const [
                                    Icon(Icons.star,
                                        size: 16, color: Colors.orange),
                                    SizedBox(width: 4.0),
                                    Text(
                                      "4.9",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      "(816)",
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
