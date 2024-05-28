import 'dart:convert';

import 'package:flutter/services.dart';

class Clothes {
  String id;
  String name;
  double price;
  List<dynamic> size;
  List<dynamic>? imageURL;
  List<dynamic> color;
  List<dynamic> colorHexValue;

  String selectedSize;
  String selectedColor;

  double? rating;
  Clothes(
      {required this.id,
      required this.name,
      required this.price,
      required this.size,
      this.imageURL,
      required this.color,
      required this.colorHexValue,
      this.selectedSize = "",
      this.selectedColor = "",
      required this.rating});

  factory Clothes.fromJson(Map<String, dynamic> json) {
    return Clothes(
      id: json['id'],
      name: json['name'],
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'],
      size: json['size'] ?? [],
      imageURL: json['imageURL'] ?? [],
      color: json['color'] ?? [],
      colorHexValue: json['color_value'] ?? [],
      rating: json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'size': size,
      'imageURL': imageURL,
      'color': color,
      'colorHexValue': colorHexValue,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'rating': rating,
    };
  }

  static Future<List<Clothes>> loadItemsFromBundle() async {
    final String response =
        await rootBundle.loadString('assets/json/clothes.json');
    final data = await json.decode(response);
    final clothesJson = data["clothes"][0]["hoodie"];
    final clothesList = <Clothes>[];

    for (var element in clothesJson) {
      clothesList.add(Clothes.fromJson(element));
    }
    return clothesList;
  }
}
