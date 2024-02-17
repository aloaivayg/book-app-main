import 'dart:convert';

import 'package:flutter/services.dart';

class Clothes {
  String id;
  String name;
  double price;
  String size;
  String? imageURL;
  String? color;
  double? rating;
  Clothes(
      {required this.id,
      required this.name,
      required this.price,
      required this.size,
      this.imageURL = "",
      required this.color,
      required this.rating});

  factory Clothes.fromJson(Map<String, dynamic> json) {
    return Clothes(
      id: json['id'],
      name: json['name'],
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'],
      size: json['size'],
      imageURL: json['imageURL'],
      color: json['color'] ?? '',
      rating: json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : json['rating'],
    );
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
