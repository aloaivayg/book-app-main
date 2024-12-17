class CreateOrderRequest {
  final String userId;
  final DateTime orderDate;
  final String paymentMethod;
  final String shippingAddress;
  final String shippingMethod;
  final Map<String, int> orderItems;
  final String discountsCode;

  CreateOrderRequest({
    required this.userId,
    required this.orderDate,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.shippingMethod,
    required this.orderItems,
    required this.discountsCode,
  });

  // fromJson
  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    return CreateOrderRequest(
      userId: json['userId'],
      orderDate: DateTime.parse(json['orderDate']),
      paymentMethod: json['paymentMethod'],
      shippingAddress: json['shippingAddress'],
      shippingMethod: json['shippingMethod'],
      orderItems: Map<String, int>.from(json['orderItems']),
      discountsCode: json['discountsCode'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderDate': orderDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress,
      'shippingMethod': shippingMethod,
      'orderItems': orderItems,
      'discountsCode': discountsCode,
    };
  }

  // copyWith
  CreateOrderRequest copyWith({
    String? userId,
    DateTime? orderDate,
    String? paymentMethod,
    String? shippingAddress,
    String? shippingMethod,
    Map<String, int>? orderItems,
    String? discountsCode,
  }) {
    return CreateOrderRequest(
      userId: userId ?? this.userId,
      orderDate: orderDate ?? this.orderDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      orderItems: orderItems ?? this.orderItems,
      discountsCode: discountsCode ?? this.discountsCode,
    );
  }
}
