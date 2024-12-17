class ServerUrl {
  static const baseUrl = 'http://localhost:8080';
  static String get productApi => "$baseUrl/public/api/products";
  static String get orderApi => "$baseUrl/public/api/orders";
}
