import 'package:book_app/src/blocs/clothes_bloc/clothes_bloc.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/page/cart/widgets/cart_total_price.dart';
import 'package:book_app/src/page/home/widget/category_title.dart';
import 'package:book_app/src/page/payment/payment.dart';
import 'package:book_app/src/provider/ClothesProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/custom_button.dart';

class CartPage extends StatefulWidget {
  CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var cartList = <Clothes>[];

  // var trendingList = Book.generateTrendingBook();
  double totalPrice = 0;
  int quantityValue = 1;
  // var quantityMap = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // cartList = context.watch<ClothesProvider>().cartItemList;
    // totalPrice = context.watch<ClothesProvider>().totalPrice;
    // quantityMap = context.watch<ClothesProvider>().cartItemQuantity;

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ClothesBloc, ClothesState>(
          builder: (context, state) {
            if (state is DataLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is ViewCartSuccess) {
              cartList = state.clothesList;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_rounded),
                            color: const Color.fromARGB(255, 254, 252, 252),
                            onPressed: () {
                              context
                                  .read<ClothesBloc>()
                                  .add(const GetAllClothesEvent());
                              Get.back();
                            },
                          ),
                        ),
                        Text("Cart"),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    Container(
                      height: 550,
                      child: ListView.separated(
                          padding: const EdgeInsets.all(20),
                          primary: false,
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (_, index) {
                            final clothes = cartList[index];
                            return GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                height: 180,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox(
                                        height: 120,
                                        child: Image.asset(
                                          clothes.imageURL![0],
                                          width: 90,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                clothes.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                context.read<ClothesBloc>().add(
                                                    RemoveCartItemEvent(
                                                        clothes: clothes));
                                              },
                                              child: Container(
                                                child: const Center(
                                                  child: FaIcon(
                                                    FontAwesomeIcons.x,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Size: ${clothes.selectedSize}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Color: ${clothes.selectedColor}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: [
                                              Text('\$${clothes.price}'),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<ClothesBloc>().add(
                                                  DecreaseCartQuantityEvent(
                                                      clothes: clothes));
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.white),
                                              child: const Center(
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 25,
                                            height: 25,
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Center(
                                              child: Text(
                                                state.clothesMap[clothes.id]
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              context.read<ClothesBloc>().add(
                                                  IncreaseCartQuantityEvent(
                                                      clothes: clothes));
                                            },
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.white),
                                              child: const Center(
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: cartList.length),
                    ),
                    Container(
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 5),
                        width: double.maxFinite,
                        child: CartTotalPriceExpansionTile(
                          totalPrice: state.totalPrice,
                        )),
                    // Container(
                    //   margin:
                    //       const EdgeInsets.only(left: 25, right: 25, top: 5),
                    //   width: double.maxFinite,
                    //   height: 80,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     color: Colors.black,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         margin: const EdgeInsets.all(10),
                    //         child: const Text(
                    //           "Total",
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: const EdgeInsets.all(10),
                    //         child: Text(
                    //           "\$${state.totalPrice.toString()}",
                    //           style: const TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PaymentPage()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 20),
                        child: const SquareButton(
                          height: 40,
                          width: 300,
                          text: "Proceed to payment",
                          color: Colors.black,
                          textColor: Colors.white,
                          borderRadius: 14,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 14,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
