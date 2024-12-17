enum Flavor {
  client_dev,
  admin_dev,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.client_dev:
        return 'Owlpha client';
      case Flavor.admin_dev:
        return 'Owlpha admin';
      default:
        return 'title';
    }
  }

}
