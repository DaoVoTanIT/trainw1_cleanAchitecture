import 'package:clean_achitecture/Theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  primaryColor: kPrimaryColor,
  secondaryHeaderColor: kPrimaryColor.withOpacity(0.5),
  //pageTransitionsTheme: _pageTransitionsTheme,
  appBarTheme: appBarTheme,
  bottomAppBarTheme: _bottomBarTheme,
  textTheme: textTheme,
  iconTheme: _iconTheme,
  buttonTheme: ButtonThemeData(
    buttonColor: kAccentColorVariant,
    disabledColor: kAccentColorVariant.withOpacity(0.5),
    splashColor: kAccentColorVariant,
    textTheme: ButtonTextTheme.primary,
  ),
  hintColor: kPrimaryColorVariant,
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color.fromRGBO(37, 37, 37, 1),
    filled: true,
  ),
  typography: Typography.material2018(),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

// const PageTransitionsTheme _pageTransitionsTheme =
//     PageTransitionsTheme(builders: {
//   TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
//   TargetPlatform.android: ZoomSlideUpTransitionsBuilder(),
// });
final _iconTheme = IconThemeData(color: Colors.white);
final _bottomBarTheme =
    BottomAppBarTheme(color: kBackgroudColor, elevation: 0.0);

final appBarTheme = AppBarTheme(
    color: kBackgroudColor,
    brightness: Brightness.light,
    elevation: 0.0,
    iconTheme: IconThemeData(color: Colors.black26),
    textTheme: textTheme);

final textTheme = TextTheme(
  headline1: TextStyles.headline1,
  headline2: TextStyles.headline2,
  headline3: TextStyles.headline3,
  headline4: TextStyles.headline4,
  headline5: TextStyles.headline5,
  headline6: TextStyles.headline6,
  subtitle1: TextStyles.subtitle1,
  subtitle2: TextStyles.subtitle2,
  bodyText1: TextStyles.bodyText1,
  bodyText2: TextStyles.bodyText2,
  button: TextStyles.button,
);

class TextStyles {
  TextStyles._();

  static final TextStyle headline1 = TextStyle(
      color: Color(0xff686795),
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5);
  static final TextStyle headline2 = TextStyle(
      color: Color(0xff686795),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5);

  static final TextStyle headline3 = TextStyle(
      color: Color(0xff686795),
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5);

  static final TextStyle headline4 = GoogleFonts.roboto(
      fontSize: 24.0,
      color: Color(0xff686795),
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5);

  static final TextStyle headline5 = GoogleFonts.roboto(
      fontSize: 26.0,
      color: Color(0xff686795),
      fontWeight: FontWeight.w500,
      letterSpacing: 1.5);

  static final TextStyle headline6 = GoogleFonts.roboto(
      fontSize: 28.0,
      color: Color(0xff686795),
      fontWeight: FontWeight.w400,
      letterSpacing: 2.0);

  static final TextStyle subtitle1 = GoogleFonts.roboto(
      fontSize: 16.0, color: Color(0xff686795), letterSpacing: 1.5);

  static final TextStyle subtitle2 = GoogleFonts.roboto(
      fontSize: 12.0, color: Color(0xffAEABC9), letterSpacing: 1.2);

  static final TextStyle bodyText1 = GoogleFonts.roboto(
      color: Color(0xff686795),
      fontSize: 14,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);

  static final TextStyle bodyText2 = GoogleFonts.roboto(
      color: Color(0xff686795),
      fontSize: 14,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);

  static final TextStyle button = GoogleFonts.roboto(
      color: Color(0xff686795),
      fontSize: 20,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);
}
