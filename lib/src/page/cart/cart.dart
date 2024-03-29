import 'package:book_app/src/model/book.dart';
import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/page/detail/detail.dart';
import 'package:book_app/src/page/home/widget/category_title.dart';
import 'package:book_app/src/page/payment/payment.dart';
import 'package:book_app/src/provider/ClothesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/custom_button.dart';
import '../../provider/BookProvider.dart';

class CartPage extends StatefulWidget {
  CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // var cartList = <Book>[];
  // var cartItemList = <Book>[];
  var cartList = <Clothes>[];

  // var trendingList = Book.generateTrendingBook();
  double totalPrice = 0;
  int quantityValue = 1;
  var quantityMap = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartList = context.watch<ClothesProvider>().cartItemList;
    totalPrice = context.watch<ClothesProvider>().totalPrice;
    quantityMap = context.watch<ClothesProvider>().cartItemQuantity;

    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider<ClothesProvider>(
          create: ((context) => ClothesProvider()),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const CategoryTitle('Cart')),
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
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => DetailPage(book)));
                          },
                          child: SizedBox(
                            height: 140,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: 120,
                                    child: Image.asset(
                                      clothes.imageURL!,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Icon(
                                          Icons.bookmark,
                                          color: Colors.orange[300],
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Size: ${clothes.size}",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Color: ${clothes.color!}",
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          _buildIconText(
                                              Icons.star,
                                              Colors.orange[300]!,
                                              '\$${clothes.price}'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // _buildIconText(
                                          //   Icons.visibility,
                                          //   Colors.white,
                                          //   '${clothes.view}M Read',
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Row(children: [
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<ClothesProvider>()
                                              .onDecrease(clothes);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          margin:
                                              const EdgeInsets.only(left: 20),
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
                                            quantityMap[clothes.name]
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<ClothesProvider>()
                                              .onIncrease(clothes);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          margin: EdgeInsets.only(),
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
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<ClothesProvider>()
                                              .onRemove(clothes);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 25,
                                          margin: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white),
                                          child: const Center(
                                            child: Text(
                                              "Remove",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      )
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
                  margin: const EdgeInsets.only(left: 25, right: 25, top: 5),
                  width: double.maxFinite,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text(
                          "Total",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "\$${totalPrice.toString()}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
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
          ),
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
