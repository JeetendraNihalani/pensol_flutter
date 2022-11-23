enum Flavor {
  dev,
  stag,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Pensol DEV';
      case Flavor.stag:
        return 'Pensol STAG';
      case Flavor.prod:
        return 'Pensol';
      default:
        return 'title';
    }
  }

    static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://rewardixrms.couponz.ws/mobile.asmx/';
      case Flavor.stag:
        return 'https://rewardixrms.couponz.ws/mobile.asmx/';
      case Flavor.prod:
        return 'https://rewardixrms.couponz.ws/mobile.asmx/';
      default:
        return 'https://rewardixrms.couponz.ws/mobile.asmx/';
    }
  }

}
