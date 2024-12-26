class ServerUrl {
  // static const baseUrl = 'http://localhost:8080';
  static const baseUrl = 'http://192.168.1.3:8080';

  static String get productApi => "$baseUrl/public/api/products";
  static String get orderApi => "$baseUrl/public/api/orders";
  static String get userApi => "$baseUrl/public/api/users";
  static String get reviewApi => "$baseUrl/public/api/reviews";
}
