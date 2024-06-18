import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var serverUrl = 'https://10.0.2.2:7209';

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

  static NumberFormat formatter =
      NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
}

class Config {
  static late SharedPreferences _prefs;
  static late String? themeMode;
  static late String? languageMode;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await loadMode();
  }

  static Future<void> setThemeMode(String mode) async {
    await _prefs.setString(Constants.themeKey, mode);
    themeMode = mode;
  }

  static Future<void> setLanguageMode(String mode) async {
    await _prefs.setString(Constants.languageKey, mode);
    languageMode = mode;
  }

  static Future<void> loadMode() async {
    themeMode = _prefs.getString(Constants.themeKey);
    if (themeMode==null) {
      await setThemeMode(Constants.defaultTheme);
      themeMode = Constants.defaultTheme;
    }

    languageMode = _prefs.getString(Constants.languageKey) ?? 'vi_VN';
  }
}

class Constants {
  static const String themeKey = "themeMode";
  static const String languageKey = "languageMode";
  static const String defaultTheme = "dark_purple";

  //static const String serverUrl = 'https://10.0.2.2:7209';
}
