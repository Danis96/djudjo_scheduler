import 'package:flutter/material.dart';

import 'color_helper.dart';

class CustomTheme {
  ThemeMode get currentTheme => ThemeMode.light;

  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: ColorHelper.mercury.color,
        elevation: 0,
        centerTitle: true, toolbarTextStyle: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: ColorHelper.monochromaticGray500.color,
          ),
        ).bodyText2, titleTextStyle: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: ColorHelper.monochromaticGray500.color,
          ),
        ).headline6,
      ),
      fontFamily: 'SourceSansPro',
      primaryColor: ColorHelper.black.color,
      backgroundColor: ColorHelper.white.color,
      errorColor: const Color.fromRGBO(232, 25, 68, 1.0),
      scaffoldBackgroundColor: ColorHelper.white.color,
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: ColorHelper.monochromaticGray500.color,
        ),
        headline2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: ColorHelper.monochromaticGray500.color,
        ),
        headline3: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: ColorHelper.monochromaticGray400.color,
        ),
        headline4: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: ColorHelper.white.color,
        ),
        headline5: TextStyle(
          color: ColorHelper.foyerBlack.color,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        headline6: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 17,
          color: ColorHelper.monochromaticGray200.color,
        ),
        subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorHelper.monoDarkGrey.color,
        ),
        subtitle2: TextStyle(
          color: ColorHelper.monochromaticGray400.color,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyText1: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: ColorHelper.monochromaticGray500.color,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorHelper.foyerBlack.color,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return ColorHelper.white.color.withOpacity(0.8);
              }
              return ColorHelper.aigCyan.color;
            },
          ),
          side: MaterialStateProperty.resolveWith<BorderSide>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(color: ColorHelper.aigCyan.color, width: 2);
              }
              return BorderSide(color: ColorHelper.aigCyan.color);
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return ColorHelper.aigCyan.color;
              }
              return ColorHelper.white.color;
            },
          ),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(const Size(104, 64)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) {
              return TextStyle(
                color: ColorHelper.white.color,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              );
            },
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        color: ColorHelper.monochromaticGray150.color,
      ),
      cardTheme: CardTheme(
        elevation: 32,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: const Color.fromRGBO(0, 92, 169, 0.2),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(
          color: Color.fromRGBO(125, 143, 161, 1),
          fontSize: 16.0,
          height: 1.7,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
        fillColor: const Color.fromRGBO(238, 238, 238, 1),
        hintStyle: const TextStyle(
          color: Color.fromRGBO(177, 177, 177, 1),
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(224, 224, 224, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(225, 225, 225, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorHelper.aigFieldError.color,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorHelper.aigFieldError.color,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
      ),
    );
  }
}
