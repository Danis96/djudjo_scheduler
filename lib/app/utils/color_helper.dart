import 'dart:ui';

import 'package:flutter/material.dart';

enum ColorHelper {
  towerBlack,
  towerNavy,
  towerSecondary,
  towerYellow,
  towerWhite,
  towerGray50,
  towerGray200,
  towerGray300,
  towerGray400,
  towerErrorRed,
  towerSuccessGreen,
  towerRed,
  towerOrange,
  towerGreen,
  towerBronze,
  towerSilver,
  towerGold,
  towerBlue,
  towerBackground,
  towerGray117,
  towerNavy2,
  towerErrorRed25,
  towerGreen25,
  towerYellow25,
  towerMapRed,
  towerUnderLimitSpeed,
}

extension ColorExtension on ColorHelper {
  Color get color {
    switch (this) {
      case ColorHelper.towerBlack:
        return const Color.fromRGBO(59, 72, 86, 1);
      case ColorHelper.towerBronze:
        return const Color.fromRGBO(201, 167, 104, 1);
      case ColorHelper.towerErrorRed:
        return const Color.fromRGBO(244, 67, 54, 1);
      case ColorHelper.towerGold:
        return const Color.fromRGBO(255, 207, 1, 1);
      case ColorHelper.towerGray50:
        return const Color.fromRGBO(250, 250, 250, 1);
      case ColorHelper.towerGray200:
        return const Color.fromRGBO(238, 238, 238, 1);
      case ColorHelper.towerGray300:
        return const Color.fromRGBO(224, 224, 224, 1);
      case ColorHelper.towerGray400:
        return const Color.fromRGBO(189, 189, 189, 1);
      case ColorHelper.towerGreen:
        return const Color.fromRGBO(39, 174, 96, 1);
      case ColorHelper.towerSuccessGreen:
        return const Color.fromRGBO(39, 174, 96, 1);
      case ColorHelper.towerNavy:
        return const Color.fromRGBO(0, 18, 114, 1);
      case ColorHelper.towerOrange:
        return const Color.fromRGBO(242, 153, 74, 1);
      case ColorHelper.towerWhite:
        return const Color.fromRGBO(255, 255, 255, 1);
      case ColorHelper.towerRed:
        return const Color.fromRGBO(235, 87, 87, 1);
        case ColorHelper.towerMapRed:
        return const Color.fromRGBO(244,96,69,1);
      case ColorHelper.towerSilver:
        return const Color.fromRGBO(162, 189, 213, 1);
      case ColorHelper.towerSecondary:
        return const Color.fromRGBO(0, 122, 204, 1);
      case ColorHelper.towerYellow:
        return const Color.fromRGBO(255, 207, 1, 1);
      case ColorHelper.towerBlue:
        return const Color.fromRGBO(0, 122, 204, 1);
      case ColorHelper.towerBackground:
        return const Color.fromRGBO(229, 229, 229, 1);
      case ColorHelper.towerGray117:
        return const Color.fromRGBO(117, 117, 117, 1);
      case ColorHelper.towerNavy2:
        return const Color.fromRGBO(2, 15, 80, 1);
      case ColorHelper.towerErrorRed25:
        return const Color.fromRGBO(244, 67, 54, 0.25);
      case ColorHelper.towerGreen25:
        return const Color.fromRGBO(76, 175, 80, 0.25);
      case ColorHelper.towerYellow25:
        return const Color.fromRGBO(242, 153, 74, 0.25);
      case ColorHelper.towerUnderLimitSpeed:
        return const Color.fromRGBO(128, 195, 165, 1);
    }
    return Colors.white;
  }
}
