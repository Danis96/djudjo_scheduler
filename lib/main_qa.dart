import 'package:flutter/material.dart';

import 'app/MyApp.dart';
import 'config/flavor_config.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.QA,
    values: FlavorValues(
      baseUrl:
      'https://raw.githubusercontent.com/JHBitencourt/ready_to_go/master/lib/json/person_qa.json',
      appName: 'DjudjoInk QA',
      loginResponseUrl: 'https://tower-test.drivercopilot.com/api/mobile/auth0/?format=json',
      webLogin: 'https://tower-test.drivercopilot.com/login/auth0/',
    ),
  );
  runApp(MyApp());
}
