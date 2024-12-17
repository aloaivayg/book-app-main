enum Flavor { CLIENT_DEV, ADMIN_DEV }

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.CLIENT_DEV:
        return 'Owlpha client';
      case Flavor.ADMIN_DEV:
        return 'Owlpha admin';
      default:
        return 'title';
    }
  }
}
