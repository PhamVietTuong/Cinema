import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

//var serverUrl = 'http://103.104.122.137:9000';
var serverUrl = 'https://10.0.2.2:7209';

class Styles {
  static const Map<String, Color> backgroundColor = {
    "dark_purple": Color(0xFF272042),
  };
  static const Map<String, Color> backgroundContent = {
    "dark_purple": Color(0xFF332E59),
    "light_purple": Colors.white
  };
  static const Map<String, Color> btnColor = {
    "dark_purple": Color(0xff802ef7),
    "light_purple": Color.fromARGB(255, 233, 218, 255)
  };
  static const Map<String, Color> boldTextColor = {
    "dark_purple": Color(0xffffffff),
    "light_purple": Colors.black
  };
  static const Map<String, Color> textColor = {
    "dark_purple": Color(0xffcccbd5),
    "light_purple": Color(0xff635D80),
  };
  static const Map<String, Color> gradientTop = {
    "dark_purple": Color(0xff802ef7),
    "light_purple": Color(0xffB654C3),
  };

  static const Map<String, Color> gradientBot = {
    "dark_purple": Color(0xffB654C3),
    "light_purple": Color(0xff7F61C8),
  };

  static const Map<String, Color> titleColor = {
    "dark_purple": Color(0xff774ECB),
    "light_purple": Color(0xff6E55A9),
  };
  static const Map<String, Color> textSelectionColor = {
    "dark_purple": Color(0xffF3F647),
    "light_purple": Color(0xffF3F647)
  };
  static const Map<String, Color> textBoldSelectionColor = {
    "dark_purple": Colors.black,
    "light_purple": Colors.white,
  };

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
  static late String? _token;
  static late DateTime? _tokenExpirationTime;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await loadMode();
  }

  static Future<void> setThemeMode(String mode) async {
    await _prefs.setString(Constants.themeModeKey, mode);
    themeMode = mode;
  }

  static Future<void> setLanguageMode(String mode) async {
    await _prefs.setString(Constants.languageModeKey, mode);
    languageMode = mode;
  }

  static Future<void> loadMode() async {
    // _prefs.remove(Constants.themeModeKey);
    themeMode = _prefs.getString(Constants.themeModeKey);
    if (themeMode == null) {
      await setThemeMode(Constants.defaultTheme);
      themeMode = Constants.defaultTheme;
    }

    languageMode = _prefs.getString(Constants.languageModeKey) ?? 'vi_VN';
  }

  static Future<void> saveToken(String token, DateTime expirationTime) async {
    _token = token;
    _tokenExpirationTime = expirationTime;

    if (expirationTime.isBefore(DateTime.now())) {
      // Token is already expired, clear it
      await clearToken();
      return;
    }

    await _prefs.setString(Constants.tokenKey, token);
    await _prefs.setString(
        Constants.tokenExpirationKey, expirationTime.toIso8601String());
  }

  static Future<void> clearToken() async {
    await _prefs.remove(Constants.tokenKey);
    await _prefs.remove(Constants.tokenExpirationKey);
  }

  static String? getToken() {
    return _token ?? _prefs.getString(Constants.tokenKey);
  }

  static Future<List<String>> loadSearchHistory() async {
    List<String> searchHistory =
        _prefs.getStringList(Constants.searchHistory) ?? [];
    return searchHistory;
  }

  static Future<void> saveSearchQuery(String query) async {
    List<String> searchHistory =
        _prefs.getStringList(Constants.searchHistory) ?? [];
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
    }
    await _prefs.setStringList(
        Constants.searchHistory, searchHistory.toSet().toList());
  }

  static Future<void> clearSearchHistory() async {
    await _prefs.remove(Constants.searchHistory);
  }

  static Future<void> removeSearchQuery(String query) async {
    List<String> searchHistory =
        _prefs.getStringList(Constants.searchHistory) ?? [];
    searchHistory.remove(query);
    await _prefs.setStringList(Constants.searchHistory, searchHistory);
  }
}

class Constants {
  static const String themeModeKey = "themeMode";
  static const String languageModeKey = "languageMode";
  static const String defaultTheme = darkPurpleTheme;
  static const String tokenKey = "token";
  static const String tokenExpirationKey = "tokenExpiration";
  static const String searchHistory = "searchHistory";

  static const String darkPurpleTheme = "dark_purple";
  static const String lightPurpleTheme = "light_purple";
  static final Map<String, String> themes = {
    darkPurpleTheme: "Chủ đề tối - Tím",
    lightPurpleTheme: "Chủ đề sáng - Tím",
  };
}
