import 'dart:convert';

import 'package:book_app/src/config/data_source/ServerUrl.dart';
import 'package:book_app/src/config/http/http_client.dart';
import 'package:book_app/src/model/variant.dart';
import 'package:flutter/services.dart';

class Clothes {
  String id;
  String productCode;
  String variantCode;
  String name;
  String description;
  double price;
  double? rating;
  String baseImageUrl;
  String category;
  String brand;

  String size;
  String color;
  String colorHexValue;
  int quantity;

  String selectedVariants;
  String selectedVariantsQuantity;

  String selectedSize;
  String selectedColor;
  String selectedColorHexValue;
  String selectedImageUrl;

  Clothes({
    required this.id,
    required this.productCode,
    required this.variantCode,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.baseImageUrl,
    required this.category,
    required this.brand,
    required this.size,
    required this.color,
    required this.colorHexValue,
    required this.quantity,
    this.selectedSize = "",
    this.selectedVariants = "",
    this.selectedVariantsQuantity = "",
    this.selectedColor = "",
    this.selectedColorHexValue = "",
    this.selectedImageUrl = "",
  });

  factory Clothes.fromJson(Map<String, dynamic> json) {
    return Clothes(
      id: json['id'],
      productCode: json['productCode'],
      variantCode: json['variantCode'],
      name: json['name'],
      description: json['description'] ?? "",
      price: json['price'] is int
          ? (json['price'] as int).toDouble()
          : json['price'],
      rating: json['rating'] is int
          ? (json['rating'] as int).toDouble()
          : json['rating'],
      baseImageUrl: "${ServerUrl.baseUrl}/${json['imageUrl']}",
      category: json['category'] ?? "",
      brand: json['brand'] ?? "",
      size: json['size'] ?? "",
      color: json['color'] ?? "",
      colorHexValue: json['colorHexValue'] ?? "",
      quantity: json['quantity'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'imageUrl': baseImageUrl,
      'category': category,
      'brand': brand,
    };
  }

  Clothes copyWith({
    String? name,
    String? productCode,
    String? description,
    double? price,
    String? category,
    String? brand,
    String? size,
    String? color,
    String? colorHexValue,
    int? quantity,
  }) {
    return Clothes(
      id: id,
      name: name ?? this.name,
      productCode: productCode ?? this.productCode,
      description: description ?? this.description,
      price: price ?? this.price,
      rating: rating, // not editable
      baseImageUrl: baseImageUrl, // not editable
      category: category ?? this.category,
      brand: brand ?? this.brand,
      size: size ?? this.size,
      color: color ?? this.color,
      colorHexValue: colorHexValue ?? this.colorHexValue,
      quantity: quantity ?? this.quantity, variantCode: variantCode,
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

  static Future<List<Clothes>> fetchClothes() async {
    final String apiUrl = '${ServerUrl.productApi}';

    final response = await HttpClient.getRequest(apiUrl);
    // print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Clothes.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
