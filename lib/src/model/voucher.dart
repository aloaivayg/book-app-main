class Voucher {
  final String code;
  final double discountPercentage;
  final DateTime expiryDate;
  final double minimumPurchase;

  Voucher(
      {required this.code,
      required this.discountPercentage,
      required this.expiryDate,
      required this.minimumPurchase});

  bool isValid() {
    final now = DateTime.now();
    return now.isBefore(expiryDate);
  }

  bool canApply(double purchaseAmount) {
    return purchaseAmount >= minimumPurchase && isValid();
  }

  double applyDiscount(double originalPrice) {
    if (!canApply(originalPrice)) {
      return originalPrice;
    }
    return originalPrice * (1 - discountPercentage / 100);
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discountPercentage': discountPercentage,
      'expiryDate': expiryDate.toIso8601String(),
      'minimumPurchase': minimumPurchase,
    };
  }

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      code: json['code'],
      discountPercentage: json['discountPercentage'],
      expiryDate: DateTime.parse(json['expiryDate']),
      minimumPurchase: json['minimumPurchase'],
    );
  }
}
