class ProductVariant {
  final String id;
  final String productCode;

  final String size;
  final String color;
  final String colorHexValue;
  final int quantity;

  // Constructor
  ProductVariant({
    required this.id,
    required this.productCode,
    required this.size,
    required this.color,
    required this.colorHexValue,
    required this.quantity,
  });

  // Factory constructor to create an instance from JSON
  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] ?? "",
      productCode: json['productCode'] ?? "",
      size: json['size'] ?? "",
      color: json['color'] ?? "",
      colorHexValue: json['colorHexValue'] ?? "",
      quantity: json['quantity'] ?? 0,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'size': size,
      'color': color,
      'colorHexValue': colorHexValue,
      'quantity': quantity,
    };
  }
}
