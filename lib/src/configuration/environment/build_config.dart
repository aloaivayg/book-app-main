abstract class CustomEnv {
  static const String clientDev = 'client_dev';
  static const String adminDev = 'admin_dev';
}

abstract class BuildConfig {
  // API and socket
  String get host;
}
