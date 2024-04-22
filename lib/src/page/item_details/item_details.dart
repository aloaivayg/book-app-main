import 'dart:convert';

import 'package:book_app/src/blocs/clothes_bloc/bloc/clothes_bloc.dart';
import 'package:book_app/src/common/const/app_list.dart';
import 'package:book_app/src/common/widgets/item_slide_show.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/page/cart/cart.dart';
import 'package:book_app/src/provider/ClothesProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/custom_button.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage();
  // final dynamic item;
  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  late List<String> sizeList;
  late List<Map<String, String>> colorList;
  late List<Color> colorList2;

  late int selectedSizeIndex;
  late int selectedColorIndex;
  late String selectedSize;
  late String selectedColor;

  @override
  void initState() {
    super.initState();
    selectedSizeIndex = -1;
    selectedColorIndex = -1;
    selectedSize = "";
    selectedColor = "";
    sizeList = resourceSizeList;
    colorList = resourceColorList;
    colorList2 = resourceColorList2;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: SingleChildScrollView(
      child: BlocBuilder<ClothesBloc, ClothesState>(
        builder: (context, state) {
          if (state is ViewClothesInfoSuccess) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_rounded),
                          color: const Color.fromARGB(255, 254, 252, 252),
                          onPressed: () {},
                        ),
                      ),
                      IconButton(
                        icon: const Icon(CupertinoIcons.add),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  // height: 400,
                  // width: double.maxFinite,

                  child: ItemSlideShow(
                    items: [state.clothes.imageURL!],
                    width: double.maxFinite,
                    heigth: 400,
                  ),
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.clothes.name),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 60),
                              child: Text("\$${state.clothes.price}"),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.grey[400],
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  height: 60,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(top: 5, left: 10),
                  child: Column(children: [
                    Row(
                      children: [
                        const Text('Size: '),
                        Text(selectedSize),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sizeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedSizeIndex = index;
                                  selectedSize = sizeList[index];
                                  state.clothes.size = selectedSize;
                                });
                              },
                              child: SquareButton(
                                  height: 20,
                                  width: 40,
                                  borderColor: Colors.blueGrey,
                                  color: selectedSizeIndex == index
                                      ? Colors.orange[300]!
                                      : Colors.white,
                                  text: sizeList[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: 60,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(top: 20, left: 10),
                  child: Column(children: [
                    Row(
                      children: const [
                        Text("Selected Color: "),
                        Text(""),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sizeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.all(4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedColorIndex = index;
                                  selectedColor =
                                      colorList[selectedColorIndex]['color']!;

                                  state.clothes.color = selectedColor;
                                });
                              },
                              child: SquareButton(
                                height: 20,
                                width: 35,
                                color: colorList2[index],
                                borderWidth:
                                    selectedColorIndex == index ? 3 : 1,
                                borderColor: selectedColorIndex == index
                                    ? Colors.blueAccent[400]!
                                    : Colors.blueGrey,
                                text: "",
                                borderRadius: 20,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 20),
                    child: const SquareButton(
                      height: 40,
                      width: 300,
                      text: "Add to cart",
                      color: Colors.black,
                      textColor: Colors.white,
                      borderRadius: 14,
                    ),
                  ),
                )
              ],
            );
          }
          return SizedBox();
        },
      ),
    )));
  }
}
