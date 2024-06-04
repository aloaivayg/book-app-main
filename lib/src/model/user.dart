import 'dart:convert';

import 'package:book_app/src/model/clothes.dart';
import 'package:flutter/services.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password; // In a real app, use hashed passwords
  final String phoneNumber;

  final String country;
  final String province;
  final String district;
  final String ward;
  final String address;

  final String avatarUrl; // URL to the user's profile picture
  final List<Clothes> cart;
  final List<Clothes> wishList;

  final List<String> orderHistory; // List of order IDs
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.country,
    required this.province,
    required this.district,
    required this.ward,
    required this.address,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.cart,
    required this.wishList,
    required this.orderHistory,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a User from a JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      country: json['country'] as String,
      province: json['province'] as String,
      district: json['district'] as String,
      ward: json['ward'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      avatarUrl: json['avatarUrl'] as String,
      cart: List<Clothes>.from(
          json['cart'].map((dynamic i) => Clothes.fromJson(i))),
      wishList: List<Clothes>.from(
          json['wishList'].map((dynamic i) => Clothes.fromJson(i))),
      orderHistory: List<String>.from(json['orderHistory'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Method to convert a User object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'country': country,
      'province': province,
      'district': district,
      'ward': ward,
      'address': address,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'cart': cart,
      'wishList': wishList,
      'orderHistory': orderHistory,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Method to update user information
  User copyWith({
    String? name,
    String? email,
    String? password,
    String? address,
    String? phoneNumber,
    String? avatarUrl,
    List<Clothes>? cart,
    List<Clothes>? wishList,
    List<String>? orderHistory,
    DateTime? updatedAt,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      cart: cart ?? this.cart,
      wishList: wishList ?? this.wishList,
      orderHistory: orderHistory ?? this.orderHistory,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      country: country,
      province: province,
      district: district,
      ward: ward,
    );
  }

  static Future<User> loadUserFromBundle() async {
    final String response =
        await rootBundle.loadString('assets/json/user.json');
    final data = await json.decode(response);
    final userJson = data["users"][0];
    final user = User.fromJson(userJson);

    return user;
  }
}
