import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../model/book.dart';

class BookProvider with ChangeNotifier, DiagnosticableTreeMixin {
  var trendingBookList = Book.generateTrendingBook();

  var tempSortBookList = Book.generateTrendingBook();

  var resultBookList = Book.generateTrendingBook();
  var toAddList = <Book>{};

  var cartBookList = <Book>[];
  var tempCartBookList = <Book>{};

  num quantity = 1;
  int totalPrice = 0;

  Map<String, int> cartItemQuantity = HashMap<String, int>();

  void onSearchBook(String keyword) {
    resultBookList.clear();
    toAddList.clear();

    trendingBookList.forEach(((element) {
      if (element.name!.toLowerCase().contains(keyword)) {
        toAddList.add(element);
      }
    }));

    resultBookList = toAddList.toList();
    notifyListeners();
  }

  void onAddBookToCart(Book book) {
    if (cartBookList.isEmpty) {
      print("object");
      tempCartBookList.add(book);
      totalPrice += book.price!;
      cartItemQuantity[book.name!] = 1;
    } else {
      for (var element in cartBookList) {
        if (element.name != book.name) {
          tempCartBookList.add(book);
          cartItemQuantity[book.name!] = 1;
          totalPrice += book.price!;
        } else {
          cartItemQuantity[book.name!] = (cartItemQuantity[book.name!]! + 1);
          totalPrice += book.price!;
        }
      }
    }
    cartBookList = tempCartBookList.toList();
    print(cartBookList.length);
    notifyListeners();
  }

  void onDecrease(Book book) {
    if (cartItemQuantity[book.name]! > 1) {
      cartItemQuantity.update(
          book.name!, (value) => cartItemQuantity[book.name]! - 1);
      totalPrice -= book.price!;
    }
  }

  void onIncrease(Book book) {
    cartItemQuantity.update(
        book.name!, (value) => cartItemQuantity[book.name]! + 1);
    totalPrice += book.price!;
  }

  void onRemove(Book book) {
    tempCartBookList.remove(book);
    cartBookList = tempCartBookList.toList();
    totalPrice -= totalPrice;
    notifyListeners();
  }

  void onSortPrice() {
    tempSortBookList.sort(((a, b) => a.view!.compareTo(b.view!)));

    resultBookList = tempSortBookList;
    notifyListeners();
  }

  void onSortStar() {
    tempSortBookList.sort(((a, b) => a.score!.compareTo(b.score!)));

    resultBookList = tempSortBookList;
    notifyListeners();
  }
}
