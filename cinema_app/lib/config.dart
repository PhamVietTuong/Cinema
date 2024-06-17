import 'package:flutter/material.dart';

var serverUrl = 'https://10.0.2.2:7209';

ThemeData lightTheme = ThemeData.light();

ThemeData darkTheme = ThemeData.dark().copyWith(
  // màu nền scaffold
  scaffoldBackgroundColor: Styles.backgroundColor["dark_purple"],
  
  primaryColor: Styles.backgroundContent["dark_purple"],
  textTheme: TextTheme(
    bodySmall: TextStyle(color: Styles.textColor["dark_purple"]),
    bodyLarge: TextStyle(color: Styles.textColor["dark_purple"]),
    titleLarge: TextStyle(color: Styles.boldTextColor["dark_purple"]),
    titleSmall: TextStyle(color: Styles.titleColor["dark_purple"]),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Styles.btnColor["dark_purple"],
  ),
  colorScheme: ColorScheme.dark(
    primary: Styles.btnColor["dark_purple"]!,
    onPrimary: Styles.boldTextColor["dark_purple"]!,
    surface: Styles.backgroundContent["dark_purple"]!,
    onSurface: Styles.textColor["dark_purple"]!,
).copyWith(
    secondary: Styles.gradientBot["dark_purple"],
),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Styles.textSelectionColor["dark_purple"],
    selectionColor: Styles.textSelectionColor["dark_purple"],
    selectionHandleColor: Styles.textSelectionColor["dark_purple"],
  ),
);

class Styles {
  static const backgroundColor = {
    "dark_purple": Color(0xFF272042),
  };
  static const backgroundContent = {"dark_purple": Color(0xFF332E59)};
  static const btnColor = {"dark_purple": Color(0xff802ef7)};
  static const boldTextColor = {"dark_purple": Color(0xffffffff)};
  static const textColor = {"dark_purple": Color(0xffcccbd5)};
  static const gradientTop = {"dark_purple": Color(0xff802ef7)};
  static const gradientBot = {"dark_purple": Color(0xffB654C3)};
  static const titleColor = {"dark_purple": Color(0xff774ECB)};
  static const textSelectionColor = {"dark_purple": Color(0xffF3F647)};

  static const titleFontSize = 18.0;
  static const textSize = 15.0;
  static const appbarFontSize = 25.0;
  static const defaultHorizontal = 15.0;

  static const primaryColor = Color(0xff802ef7);
  static const soldColor = Colors.grey;
  static const coupleSeatColor = Colors.green;
  static const singleSeatColor = Colors.amber;
  static const selectedSeatColor = Colors.lightBlue;
  static const waitingSeatColor = Colors.deepOrangeAccent;

  static const iconSizeInLineText = 20.0;
  static const iconSizeInTitle = 30.0;
  static const iconInAppBar = 25.0;
}
