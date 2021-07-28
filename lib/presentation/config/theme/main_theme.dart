import 'package:flutter/material.dart';

import 'constant_styling.dart';

ThemeData mainTheme() {
  final fontFamily = aFontFamily;
  final primaryColor = aRed;
  final accentColor = aLightRed;

  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        color: aDarkTextColor,
      ),
      headline2: base.headline2!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        color: aDarkTextColor,
      ),
      headline3: base.headline3!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        color: aDarkTextColor,
      ),
      headline4: base.headline4!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 30,
        color: aDarkTextColor,
      ),
      headline5: base.headline5!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        color: aDarkTextColor,
      ),
      headline6: base.headline6!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: aDarkTextColor,
      ),
      bodyText1: base.bodyText1!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        color: aDarkTextColor,
      ),
      bodyText2: base.bodyText2!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        color: aDarkTextColor,
      ),
      subtitle1: base.subtitle1!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        color: aDarkTextColor,
      ),
      subtitle2: base.subtitle2!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        color: aDarkTextColor,
      ),
      button: base.subtitle2!.copyWith(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      caption: base.caption!.copyWith(
        fontFamily: fontFamily,
        letterSpacing: 3,
        color: aLightTextColor,
      ),
      overline: base.overline!.copyWith(
        fontFamily: fontFamily,
        color: aLightTextColor,
      ),
    );
  }

  final ThemeData base = ThemeData.light();

  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    primaryColor: primaryColor,
    hintColor: aBorderColor.withAlpha(95),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black.withOpacity(0),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black.withOpacity(0),
    ),
    scaffoldBackgroundColor: aBackgroundColor,
    accentColor: accentColor,
  );
}
