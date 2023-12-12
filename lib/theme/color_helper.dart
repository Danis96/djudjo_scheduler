
import 'package:flutter/material.dart';

enum ColorHelper {
  white,
  black,
  monochromaticGray150,
  mercury,
  monochromaticGray500,
  monochromaticGray400,
  monochromaticGray300,
  foyerBlack,
  monochromaticGray200,
  monoDarkGrey,
  aIGCoreBlue,
  aIGCobalt,
  primaryBlue,
  aIGPaleBlue,
  aigFieldError,
  aigDarkGrey,
  foyerLightBlue,
  aigCyan,
  aigOrange,
  aigYellow,
  aigPurple,
  aigGray2,
  amodoBlack,
  tripSpeeding,
  tripUnderLimit,
  cobaltBlue,
  semanticGreen,
  aIGDivider,
  aigAppBarBlue,
  aigPaleGreen,
  aigGreen,
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
      case ColorHelper.white:
        //#FFFFFF
        return const Color.fromRGBO(255, 255, 255, 1);
      case ColorHelper.black:
        //#000000
        return const Color.fromRGBO(0, 0, 0, 1);
      case ColorHelper.monochromaticGray150:
        //#EEEEEE
        return const Color.fromRGBO(238, 238, 238, 1);
      case ColorHelper.mercury:
        //#E5E5E5
        return const Color.fromRGBO(229, 229, 229, 1);
      case ColorHelper.monochromaticGray500:
        //#212121
        return const Color.fromRGBO(33, 33, 33, 1);
      case ColorHelper.monochromaticGray400:
        //#616161
        return const Color.fromRGBO(97, 97, 97, 1);
      case ColorHelper.foyerBlack:
        //#3B4856
        return const Color.fromRGBO(59, 72, 86, 1);
      case ColorHelper.monochromaticGray200:
        //#E0E0E0
        return const Color.fromRGBO(224, 224, 224, 1);
      case ColorHelper.monoDarkGrey:
        //#6E6E6E
        return const Color.fromRGBO(110, 110, 110, 1);
      case ColorHelper.aIGCoreBlue:
        //#021764
        return const Color.fromRGBO(2, 23, 100, 1);
      case ColorHelper.aIGCobalt:
        //#1352DE
        return const Color.fromRGBO(19, 82, 222, 1);
      case ColorHelper.primaryBlue:
        //#05176C
        return const Color.fromRGBO(5, 23, 108, 1);
      case ColorHelper.aIGPaleBlue:
        //#C0D6F1
        return const Color.fromRGBO(192, 214, 241, 1);
      case ColorHelper.aigFieldError:
        return const Color.fromRGBO(232, 25, 68, 1);
      case ColorHelper.aigDarkGrey:
        return const Color.fromRGBO(52, 55, 65, 1);
      case ColorHelper.foyerLightBlue:
        return const Color.fromRGBO(91, 175, 251, 1);
      case ColorHelper.aigCyan:
        return const Color.fromRGBO(15, 153, 221, 1);
      case ColorHelper.monochromaticGray300:
        return const Color.fromRGBO(158, 158, 158, 1);
      case ColorHelper.aigOrange:
        //#FF8200
        return const Color.fromRGBO(255, 130, 0, 1);
      case ColorHelper.aigYellow:
        //#FFBF3F
        return const Color.fromRGBO(255, 191, 63, 1);
      case ColorHelper.aigPurple:
        //##904FD8
        return const Color.fromRGBO(144, 79, 216, 1);
      case ColorHelper.amodoBlack:
        //##231F20
        return const Color.fromRGBO(35, 31, 32, 1);
      case ColorHelper.tripSpeeding:
        //##F46045
        return const Color.fromRGBO(244, 96, 69, 1);
      case ColorHelper.tripUnderLimit:
        //#F6A145;
        return const Color.fromRGBO(246, 161, 69, 1);
      case ColorHelper.aigGray2:
        //#64717E
        return const Color.fromRGBO(100, 113, 126, 1);
      case ColorHelper.semanticGreen:
        return const Color.fromRGBO(140, 209, 135, 1);
      case ColorHelper.aIGDivider:
        //#F6F9FC
        return const Color.fromRGBO(246, 249, 252, 1);
      case ColorHelper.aigAppBarBlue:
        //#1748D5
        return const Color.fromRGBO(23, 72, 213, 1);
      case ColorHelper.aigPaleGreen:
        return const Color.fromRGBO(189, 240, 223, 1);
      case ColorHelper.aigGreen:
        return const Color.fromRGBO(0, 191, 111, 1);
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
        return const Color.fromRGBO(244, 96, 69, 1);
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
        return const Color.fromRGBO(28, 47, 145, 1);
      case ColorHelper.towerErrorRed25:
        return const Color.fromRGBO(244, 67, 54, 0.25);
      case ColorHelper.towerGreen25:
        return const Color.fromRGBO(76, 175, 80, 0.25);
      case ColorHelper.towerYellow25:
        return const Color.fromRGBO(242, 153, 74, 0.25);
      case ColorHelper.towerUnderLimitSpeed:
        return const Color.fromRGBO(128, 195, 165, 1);
      default:
        return Colors.white;
    }
  }
}
