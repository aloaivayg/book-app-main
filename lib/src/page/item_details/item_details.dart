import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:book_app/src/common/const/app_list.dart';
import 'package:book_app/src/common/widgets/custom_appbar.dart';
import 'package:book_app/src/common/widgets/custom_bottom_navbar.dart';
import 'package:book_app/src/common/widgets/item_slide_show.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/model/user.dart';
import 'package:book_app/src/page/cart/cart.dart';
import 'package:book_app/src/page/item_details/widgets/comment.dart';
import 'package:book_app/src/page/item_details/widgets/comment_section.dart';
import 'package:book_app/src/page/item_details/widgets/item_description.dart';
import 'package:book_app/src/page/item_details/widgets/rating_star.dart';
import 'package:book_app/src/page/item_details/widgets/review_dialog.dart';
import 'package:book_app/src/page/user/login/login.dart';
import 'package:book_app/src/util/color_from_hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../common/widgets/custom_button.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  late List<String> sizeList;
  late List<String> hexColorList;

  late List<Map<String, String>> colorList;
  late List<Color> colorList2;

  late int selectedSizeIndex;
  late int selectedColorIndex;
  late String selectedSize;
  late String selectedColor;

  late String description;

  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    userBloc = context.read<UserBloc>();

    selectedSizeIndex = -1;
    selectedColorIndex = -1;
    selectedSize = "";
    selectedColor = "";
    sizeList = [];
    hexColorList = [];
    colorList = resourceColorList;
    colorList2 = resourceColorList2;
    description = "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const CustomAppBar(title: ""),
      body: SingleChildScrollView(
        child: BlocConsumer<ClothesBloc, ClothesState>(
          builder: (context, state) {
            if (state is DataLoading) {
              return Container(
                  width: Get.width,
                  height: Get.height,
                  child: const Center(child: CircularProgressIndicator()));
            }
            if (state is ViewClothesInfoSuccess) {
              userBloc
                  .add(GetReviewByProductIdEvent(productId: state.clothes.id));

              List<String> slideShowImage = [];
              String baseImg = state.clothes.baseImageUrl;
              hexColorList = [];
              sizeList = [];
              // Color filter
              Set<String> seenColors = {};
              slideShowImage.addAll(state.selectClothesList
                  .where((element) =>
                      seenColors.add(element.color)) // Adds only new colors
                  .map((element) => baseImg));
              seenColors = {};
              hexColorList.addAll(state.selectClothesList
                  .where((element) =>
                      seenColors.add(element.color)) // Adds only new colors
                  .map((element) => element.colorHexValue));
              print(hexColorList.length);
              description = state.clothes.description;
              // Size filter
              Set<String> seenSizes = {};
              sizeList.addAll(state.selectClothesList
                  .where((element) =>
                      seenSizes.add(element.size)) // Adds only new sizes
                  .map((element) => element.size));

              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    alignment: Alignment.center,
                    child: ItemSlideShow(
                      items: slideShowImage,
                      width: 300,
                      heigth: 400,
                      selectedIndex: selectedColorIndex,
                    ),
                  ),
                  Container(
                      height: 80,
                      // margin: const EdgeInsets.only(top: 20, left: 10),
                      margin:
                          const EdgeInsets.only(top: 10, left: 30, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(child: Text(state.clothes.name)),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: const FaIcon(FontAwesomeIcons.heart),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "\$${state.clothes.price}",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: RatingStars(rating: 4.5),
                              ),
                            ],
                          )
                        ],
                      )),
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(top: 10, left: 30, right: 20),
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
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSizeIndex = index;
                                    selectedSize = sizeList[index];
                                    state.clothes.selectedSize = selectedSize;
                                  });

                                  context.read<ClothesBloc>().add(
                                      EnableAddToCartEvent(
                                          selectedSizeIndex: selectedSizeIndex,
                                          selectedColorIndex:
                                              selectedColorIndex,
                                          clothes: state.clothes));
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
                    margin: const EdgeInsets.only(top: 10, left: 30, right: 20),
                    child: Column(children: [
                      const Row(
                        children: [
                          Text("Selected Color: "),
                          Text(""),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hexColorList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColorIndex = index;
                                    selectedColor =
                                        colorList[selectedColorIndex]['color']!;

                                    state.clothes.selectedColor = selectedColor;
                                    state.clothes.selectedImageUrl =
                                        slideShowImage[selectedColorIndex];
                                  });

                                  context.read<ClothesBloc>().add(
                                      EnableAddToCartEvent(
                                          selectedSizeIndex: selectedSizeIndex,
                                          selectedColorIndex:
                                              selectedColorIndex,
                                          clothes: state.clothes));
                                },
                                child: SquareButton(
                                  height: 20,
                                  width: 35,
                                  color: HexColor.fromHex(hexColorList[index]),
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
                  Container(
                    height: 40,
                    width: 300,
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    alignment: Alignment.center,
                    color: const Color.fromARGB(255, 91, 50, 50),
                    child: Text(
                      "Size based on height",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: state.isEnabled
                        ? () {
                            context.read<ClothesBloc>().add(
                                AddClothesToCartEvent(clothes: state.clothes));

                            showAddToCartDialog(context);
                          }
                        : null,
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 15, bottom: 20, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareButton(
                            height: 40,
                            width: 250,
                            text: "Add to cart",
                            color: state.isEnabled ? Colors.black : Colors.grey,
                            textColor: Colors.white,
                            borderRadius: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      width: double.maxFinite,
                      margin:
                          const EdgeInsets.only(top: 10, left: 30, right: 20),
                      alignment: Alignment.centerLeft,
                      child: DescriptionExpansionTile(
                        description: description,
                      )),
                  Container(
                      width: double.maxFinite,
                      margin:
                          const EdgeInsets.only(top: 10, left: 30, right: 20),
                      alignment: Alignment.centerLeft,
                      child: BlocConsumer<UserBloc, UserState>(
                        listener: (context, userState) {
                          if (userState is CreateReviewSuccess) {
                            userBloc.add(GetReviewByProductIdEvent(
                                productId: state.clothes.id));
                          }
                        },
                        builder: (context, userState) {
                          if (userState is GetReviewByProductIdSuccess) {
                            return ItemDetailCommentSection(
                              reviews: userState.reviewList,
                            );
                          }

                          return const ItemDetailCommentSection(
                            reviews: [],
                          );
                        },
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider()),
                  Container(
                      width: double.maxFinite,
                      margin:
                          const EdgeInsets.only(top: 10, left: 30, right: 20),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FaIcon(FontAwesomeIcons.pen),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (userBloc.user != null) {
                                showReviewDialog(
                                    context, state.clothes, userBloc.user!);
                              } else {
                                print("To login screen");
                                Get.to(LoginScreen())!.then((_) {
                                  Get.back(result: true);
                                });
                              }
                            },
                            child: Text(
                              "Leave a review",
                              style: TextStyle(color: Colors.blue[400]),
                            ),
                          )
                        ],
                      )),
                ],
              );
            }

            return const SizedBox();
          },
          listener: (BuildContext context, ClothesState state) {
            if (state is ViewClothesInfoSuccess) {
              userBloc
                  .add(GetReviewByProductIdEvent(productId: state.clothes.id));
            }
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    ));
  }

  void showReviewDialog(BuildContext context, Clothes clothes, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReviewDialog(onSubmit: (reviewData) {
          // Create the formData
          final formData = {
            "productId": clothes.id, // Replace with actual product ID
            "userId": user.id, // Replace with actual user ID
            "rating": reviewData["rating"],
            "fit": reviewData["fit"],
            "title": reviewData["title"],
            "comment": reviewData["comment"],
            "createdAt": DateTime.now().toIso8601String(),
          };

          userBloc.add(CreateReviewEvent(formData: formData));
          setState(() {});
        });
      },
    );
  }

  void showAddToCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Item Added to Cart"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("You have successfully added the item to your cart."),
              SizedBox(height: 20),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Continue Shopping"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Go to Cart"),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<ClothesBloc>().add(const ViewCartEvent());
                Get.off(const CartPage());
              },
            ),
          ],
        );
      },
    );
  }
}
