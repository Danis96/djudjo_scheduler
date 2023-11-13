import 'package:flutter/foundation.dart';

enum Flavor {
  DEV,
  QA,
  PRODUCTION,
}

class FlavorValues {
  FlavorValues({
    // required this.baseUrl,
    required this.appName,
    // required this.loginResponseUrl,
    // required this.webLogin,
  });
  // final String baseUrl;
  final String appName;
  // final String loginResponseUrl;
  // final String webLogin;
}

class FlavorConfig {
  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
  }) {
    _instance ??= FlavorConfig._internal(flavor, flavor.toString(), values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);

  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance?.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance?.flavor == Flavor.DEV;
  static bool isQA() => _instance?.flavor == Flavor.QA;
}
