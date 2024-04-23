import 'package:book_app/src/blocs/clothes_bloc/bloc/clothes_bloc.dart';

import 'package:book_app/src/model/clothes.dart';
import 'package:book_app/src/page/home/widget/category_title.dart';
import 'package:book_app/src/provider/ClothesProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../item_details/item_details.dart';

class TrendingClothes extends StatefulWidget {
  const TrendingClothes({Key? key}) : super(key: key);

  @override
  State<TrendingClothes> createState() => _TrendingClothesState();
}

class _TrendingClothesState extends State<TrendingClothes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClothesBloc, ClothesState>(
      builder: (context, state) {
        if (state is DataLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is FetchClothesSuccess) {
          return Column(
            children: [
              const CategoryTitle('Trending'),
              ListView.separated(
                padding: const EdgeInsets.all(20),
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (_, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: state.clothesList!.length,
                itemBuilder: (_, index) {
                  // final book = trendingList[index];

                  final clothes = state.clothesList![index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ItemInfoPage()));
                    },
                    child: SizedBox(
                      height: 120,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 120,
                              width: 100,
                              child: Image.asset(
                                clothes.imageURL![0],
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
                                clothes.name!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                clothes.name!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  _buildIconText(
                                      Icons.star,
                                      Colors.orange[300]!,
                                      '${clothes.size}${clothes.rating}'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  _buildIconText(
                                    Icons.price_change_sharp,
                                    Colors.white,
                                    '${clothes.price}',
                                  ),
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                },
              )
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
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
