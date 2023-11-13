import 'package:flutter/material.dart';

import 'app/MyApp.dart';
import 'config/flavor_config.dart';

void main() {
  FlavorConfig(flavor: Flavor.QA, values: FlavorValues(appName: 'DjudjoInk QA'));
  runApp(MyApp());
}
