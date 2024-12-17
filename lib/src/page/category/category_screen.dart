import 'package:book_app/src/common/widgets/category_bar.dart';
import 'package:book_app/src/common/widgets/custom_appbar.dart';
import 'package:book_app/src/common/widgets/custom_bottom_navbar.dart';
import 'package:book_app/src/model/category.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: "Category",
      ),
      body: CategoryScreenDetails(),
      bottomNavigationBar: CustomBottomNavBar(),
    ));
  }
}

class CategoryScreenDetails extends StatefulWidget {
  const CategoryScreenDetails({Key? key}) : super(key: key);

  @override
  State<CategoryScreenDetails> createState() => _CategoryScreenDetailsState();
}

class _CategoryScreenDetailsState extends State<CategoryScreenDetails> {
  late List<Category> categories;

  @override
  void initState() {
    categories = [
      Category(
        title: 'Women',
        subcategories: [
          Subcategory(imageUrl: '', label: 'Outerwear'),
          Subcategory(imageUrl: '', label: 'Knitwear'),
          Subcategory(imageUrl: '', label: 'Tops'),
          Subcategory(imageUrl: '', label: 'Dresses'),
          Subcategory(imageUrl: '', label: 'T-Shirt'),
          Subcategory(imageUrl: '', label: 'Shirt'),
          Subcategory(imageUrl: '', label: 'Hoodie'),
        ],
      ),
      Category(
        title: 'Men',
        subcategories: [
          Subcategory(imageUrl: '', label: 'Outerwear'),
          Subcategory(imageUrl: '', label: 'Knitwear'),
          Subcategory(imageUrl: '', label: 'T-Shirt'),
          Subcategory(imageUrl: '', label: 'Shirt'),
          Subcategory(imageUrl: '', label: 'Hoodie'),
        ],
      ),
      Category(
        title: 'Kid',
        subcategories: [
          Subcategory(imageUrl: '', label: 'Shirt'),
          Subcategory(imageUrl: '', label: 'T-Shirt'),
        ],
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CategoryGrid(
        categories: categories,
      ),
    );
  }
}
