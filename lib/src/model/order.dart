import 'package:book_app/src/model/clothes.dart';

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled;

  static OrderStatus? getOrderStatusFromString(String status) {
    try {
      return OrderStatus.values.firstWhere(
        (e) => e.name == status.toLowerCase(),
        orElse: () => throw ArgumentError('Invalid OrderStatus: $status'),
      );
    } catch (_) {
      return null;
    }
  }
}

class Order {
  final String orderId;
  final String userId;
  final DateTime orderDate;
  OrderStatus status;
  final double totalAmount;
  final String paymentMethod;
  final String paymentStatus;
  final String shippingAddress;
  final String shippingMethod;
  final double shippingCost;

  final List<Clothes> orderItems;
  final double discounts;
  final double taxAmount;
  final String? couponCode;

  final DateTime? deliveryDate;
  final String? notes;
  final bool isGift;
  final String? giftMessage;

  Order({
    required this.orderId,
    required this.userId,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.shippingAddress,
    required this.shippingMethod,
    required this.shippingCost,
    required this.orderItems,
    required this.discounts,
    required this.taxAmount,
    this.couponCode,
    this.deliveryDate,
    this.notes,
    required this.isGift,
    this.giftMessage,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      userId: json['userId'],
      orderDate: DateTime.parse(json['orderDate']),
      status: OrderStatus.getOrderStatusFromString(json['status'])!,
      totalAmount: json['totalAmount'].toDouble(),
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      shippingAddress: json['shippingAddress'] ?? "",
      shippingMethod: json['shippingMethod'],
      shippingCost: json['shippingCost'].toDouble(),
      orderItems: (json['orderItems'] as List)
          .map((item) => Clothes.fromJson(item))
          .toList(),
      discounts: json['discounts'].toDouble(),
      taxAmount: json['taxAmount'].toDouble(),
      couponCode: json['couponCode'],
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      notes: json['notes'],
      isGift: json['gift'],
      giftMessage: json['giftMessage'],
    );
  }

  // CopyWith method
  Order copyWith({
    String? orderId,
    String? userId,
    DateTime? orderDate,
    OrderStatus? status,
    double? totalAmount,
    String? paymentMethod,
    String? paymentStatus,
    String? shippingAddress,
    String? shippingMethod,
    double? shippingCost,
    String? trackingNumber,
    List<Clothes>? orderItems,
    double? discounts,
    double? taxAmount,
    String? couponCode,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deliveryDate,
    String? notes,
    bool? isGift,
    String? giftMessage,
  }) {
    return Order(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      shippingCost: shippingCost ?? this.shippingCost,
      orderItems: orderItems ?? this.orderItems,
      discounts: discounts ?? this.discounts,
      taxAmount: taxAmount ?? this.taxAmount,
      couponCode: couponCode ?? this.couponCode,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      notes: notes ?? this.notes,
      isGift: isGift ?? this.isGift,
      giftMessage: giftMessage ?? this.giftMessage,
    );
  }
}
