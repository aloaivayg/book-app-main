import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../model/book.dart';
import '../model/clothes.dart';

class ClothesProvider with ChangeNotifier, DiagnosticableTreeMixin {
  var trendingClothesList = <Clothes>[];
  // var tempSortClothesList = Clothes.generateTrendingClothesList();

  var searchResultList = <Clothes>[];
  var tempSearchResult = <Clothes>{};

  var itemDetail;

  var cartItemList = <Clothes>[];
  var tempCartItemList = <Clothes>{};

  num quantity = 1;
  double totalPrice = 0;

  Map<String, int> cartItemQuantity = HashMap<String, int>();

  var tempSortItemList = <Clothes>[];

  void generateList() {
    Clothes.loadItemsFromBundle().then((value) {
      trendingClothesList = value;
      searchResultList = value;
    }).whenComplete(() {
      notifyListeners();
    });
  }

  void onSearchClothes(String keyword) {
    // searchResultList.clear();
    tempSearchResult.clear();

    trendingClothesList.forEach(((element) {
      if (element.name.toLowerCase().contains(keyword)) {
        tempSearchResult.add(element);
      }
    }));

    searchResultList = tempSearchResult.toList();

    notifyListeners();
  }

  void onClickItem(Clothes clothes) {
    itemDetail = clothes;
    notifyListeners();
  }

  void onAddItemToCart(Clothes clothes) {
    if (cartItemList.isEmpty) {
      // print("object");
      tempCartItemList.add(clothes);
      totalPrice += clothes.price;
      cartItemQuantity[clothes.name] = 1;
    } else {
      for (var element in cartItemList) {
        if (element.name != clothes.name) {
          tempCartItemList.add(clothes);
          cartItemQuantity[clothes.name] = 1;
          totalPrice += clothes.price;
        } else {
          cartItemQuantity[clothes.name] =
              (cartItemQuantity[clothes.name]! + 1);
          totalPrice += clothes.price;
        }
      }
    }
    cartItemList = tempCartItemList.toList();

    notifyListeners();
  }

  void onDecrease(Clothes clothes) {
    if (cartItemQuantity[clothes.name]! > 1) {
      cartItemQuantity.update(
          clothes.name, (value) => cartItemQuantity[clothes.name]! - 1);
      totalPrice -= clothes.price;
    }
  }

  void onIncrease(Clothes clothes) {
    cartItemQuantity.update(
        clothes.name, (value) => cartItemQuantity[clothes.name]! + 1);
    totalPrice += clothes.price;
  }

  void onRemove(Clothes clothes) {
    tempCartItemList.remove(clothes);
    cartItemList = tempCartItemList.toList();
    totalPrice -= totalPrice;
    notifyListeners();
  }

  void onSortPrice() {
    tempSortItemList = searchResultList;

    tempSortItemList.sort(((a, b) => a.price.compareTo(b.price)));

    searchResultList = tempSortItemList;
    notifyListeners();
  }

  void onSortStar() {
    tempSortItemList = searchResultList;
    tempSortItemList.sort(((a, b) => a.rating!.compareTo(b.rating!)));

    searchResultList = tempSortItemList;
    notifyListeners();
  }
}
