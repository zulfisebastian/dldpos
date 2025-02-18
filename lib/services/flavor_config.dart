import '../utils/extensions.dart';

enum Flavor { DEV, PRODUCTION }

class FlavorValues {
  FlavorValues({
    required this.baseUrl,
    required this.playStoreBundle,
    required this.appStoreBundle,
    required this.appStoreId,
    required this.dynamicLinkUrl,
  });

  final String baseUrl;
  final String playStoreBundle;
  final String appStoreBundle;
  final String appStoreId;
  final String dynamicLinkUrl;
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(
      flavor,
      StringExt.enumName(flavor.toString()),
      values,
    );
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);
  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance!.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance!.flavor == Flavor.DEV;
}
