import 'package:book_app/src/blocs/clothes_bloc/bloc/clothes_bloc.dart';
import 'package:book_app/src/page/home/widget/category_title.dart';

import 'package:book_app/src/page/item_details/item_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/clothes.dart';

class RecommendedItem extends StatefulWidget {
  const RecommendedItem({Key? key}) : super(key: key);

  @override
  State<RecommendedItem> createState() => _RecommendedItemState();
}

class _RecommendedItemState extends State<RecommendedItem> {
  // var trendingClothesList = <Clothes>[];

  var recommendedList = <Clothes>[];
  late ScrollController _scrollController;

  late double leftScrollConstraint;
  late double rightScrollConstraint;

  bool isSelected = false;
  int selectedItem = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    leftScrollConstraint = 0;
    rightScrollConstraint = 0;
  }

  @override
  Widget build(BuildContext context) {
    leftScrollConstraint = MediaQuery.of(context).size.width / 3;
    rightScrollConstraint = MediaQuery.of(context).size.width / 1.5;
    return BlocBuilder<ClothesBloc, ClothesState>(
      builder: (context, state) {
        if (state is DataLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is FetchClothesSuccess) {
          return Column(
            children: [
              const CategoryTitle('Recommended for you'),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(20),
                  itemCount: state.clothesList!.length,
                  itemBuilder: (_, index) {
                    var clothes = state.clothesList![index];
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<ClothesBloc>()
                            .add(ViewClothesInfoEvent(clothes: clothes));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ItemInfoPage()));
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 130,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      clothes.imageURL!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    clothes.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "\$${clothes.price.toString()}",
                                  style: const TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              top: 10,
                              left: 10,
                              child: _buildIconText(Icons.star,
                                  Colors.orange[300]!, '${clothes.rating}'))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Container(
          color: Colors.amber,
        );
      },
    );
  }

  Widget _buildIconText(IconData icon, Color color, String text) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
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
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          )
        ],
      ),
    );
  }
}
