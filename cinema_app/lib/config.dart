import 'dart:convert';

import 'package:cinema_app/data/models/invoice.dart';
import 'package:cinema_app/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

var serverUrl = 'http://103.104.122.137:9000';
//var serverUrl = 'https://10.0.2.2:7209';

class Styles {
  static const Map<String, Color> backgroundColor = {
    "dark_purple": Color(0xFF272042),
    "light_purple": Color.fromARGB(255, 238, 231, 245),
    "dark_blue": Color(0xFF1B263B),
    "light_blue": Color(0xFFDCEEFB),
    "dark_green": Color(0xFF1B5E20),
    "light_green": Color(0xFFE8F5E9),
    "dark_red": Color(0xFFB71C1C),
    "light_red": Color(0xFFFFEBEE),
    "dark_yellow": Color(0xFFB7950B),
    "light_yellow": Color(0xFFFFF9C4),
  };

  static const Map<String, Color> backgroundContent = {
    "dark_purple": Color(0xFF332E59),
    "light_purple": Color.fromARGB(255, 228, 215, 244),
    "dark_blue": Color(0xFF243B55),
    "light_blue": Color(0xFFC1E1F9),
    "dark_green": Color(0xFF2E7D32),
    "light_green": Color(0xFFC8E6C9),
    "dark_red": Color(0xFFC62828),
    "light_red": Color(0xFFFFCDD2),
    "dark_yellow": Color(0xFF7D5A09),
    "light_yellow": Color(0xFFFFE082),
  };

  static const Map<String, Color> btnColor = {
    "dark_purple": Color(0xff802ef7),
    "light_purple": Color.fromARGB(255, 233, 218, 255),
    "dark_blue": Color(0xFF007BFF),
    "light_blue": Color(0xFF74C0FC),
    "dark_green": Color(0xFF4CAF50),
    "light_green": Color(0xFFA5D6A7),
    "dark_red": Color(0xFFD32F2F),
    "light_red": Color(0xFFEF5350),
    "dark_yellow": Color(0xFFC79100),
    "light_yellow": Color(0xFFFFD54F),
  };

  static const Map<String, Color> boldTextColor = {
    "dark_purple": Color(0xffffffff),
    "light_purple": Colors.black,
    "dark_blue": Color(0xFFFFFFFF),
    "light_blue": Color(0xFF003366),
    "dark_green": Color(0xFFFFFFFF),
    "light_green": Color(0xFF1B5E20),
    "dark_red": Color(0xFFFFFFFF),
    "light_red": Color(0xFFB71C1C),
    "dark_yellow": Color(0xFFFFFFFF),
    "light_yellow": Color(0xFF7D5A09),
  };

  static const Map<String, Color> textColor = {
    "dark_purple": Color(0xffcccbd5),
    "light_purple": Color(0xff635D80),
    "dark_blue": Color(0xFFB0C4DE),
    "light_blue": Color(0xFF1C3D5A),
    "dark_green": Color(0xFFA5D6A7),
    "light_green": Color(0xFF2E7D32),
    "dark_red": Color(0xFFFFCDD2),
    "light_red": Color(0xFFB71C1C),
    "dark_yellow": Color(0xFFB7950B),
    "light_yellow": Color(0xFF7D5A09),
  };

  static const Map<String, Color> gradientTop = {
    "dark_purple": Color(0xff802ef7),
    "light_purple": Color(0xff802ef7),
    "dark_blue": Color(0xFF1E90FF),
    "light_blue": Color(0xFF1E90FF),
    "dark_green": Color(0xFF43A047),
    "light_green": Color(0xFF66BB6A),
    "dark_red": Color(0xFFE53935),
    "light_red": Color(0xFFEF5350),
    "dark_yellow": Color(0xFFC79100),
    "light_yellow": Color(0xFFFFE082),
  };

  static const Map<String, Color> gradientBot = {
    "dark_purple": Color(0xffB654C3),
    "light_purple": Color(0xffB654C3),
    "dark_blue": Color(0xFF4682B4),
    "light_blue": Color(0xFF4682B4),
    "dark_green": Color(0xFF388E3C),
    "light_green": Color(0xFF81C784),
    "dark_red": Color(0xFFD32F2F),
    "light_red": Color(0xFFE57373),
    "dark_yellow": Color(0xFF7D5A09),
    "light_yellow": Color(0xFFFFD54F),
  };

  static const Map<String, Color> titleColor = {
    "dark_purple": Color(0xff774ECB),
    "light_purple": Color(0xff6E55A9),
    "dark_blue": Color(0xFF1C86EE),
    "light_blue": Color(0xFF1C86EE),
    "dark_green": Color(0xFF2E7D32),
    "light_green": Color(0xFF388E3C),
    "dark_red": Color(0xFFC62828),
    "light_red": Color(0xFFE53935),
    "dark_yellow": Color(0xFF7D5A09),
    "light_yellow": Color(0xFF7D5A09),
  };

  static const Map<String, Color> textSelectionColor = {
    "dark_purple": Color(0xffF3F647),
    "light_purple": Color(0xffF3F647),
    "dark_blue": Color(0xffB0E0E6),
    "light_blue": Color(0xffB0E0E6),
    "dark_green": Color(0xffC8E6C9),
    "light_green": Color(0xffC8E6C9),
    "dark_red": Color(0xFFFFCDD2),
    "light_red": Color(0xFFFFCDD2),
    "dark_yellow": Color(0xFFFFF59D),
    "light_yellow": Color(0xFFFFF9C4),
  };

  static const Map<String, Color> textBoldSelectionColor = {
    "dark_purple": Colors.black,
    "light_purple": Colors.white,
    "dark_blue": Color(0xFF000000),
    "light_blue": Color(0xFFFFFFFF),
    "dark_green": Color(0xFF000000),
    "light_green": Color(0xFFFFFFFF),
    "dark_red": Color(0xFF000000),
    "light_red": Color(0xFFFFFFFF),
    "dark_yellow": Color(0xFF000000),
    "light_yellow": Color(0xFF000000),
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
  static String formatDay(DateTime day) {
    return '${day.day.toString().padLeft(2, "0")}/${day.month.toString().padLeft(2, "0")}/${day.year}';
  }

  static String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}:${time.second.toString().padLeft(2, "0")}';
  }

  static String formatDateTime(DateTime time) {
    return '${formatTime(time)} ${formatDay(time)}';
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAllMapped(RegExp(r'^(\d{3})(\d{3})(\d{4,})$'),
        (match) => '${match[1]} ${match[2]} ${match[3]}');
  }

  static formatSecond(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  static Future<String> translate(String text) async {
    final translator = GoogleTranslator();
    return await translator
        .translate(text, to: Config.languageMode!)
        .then((value) => value.text);
  }
}

class Config {
  static late SharedPreferences _prefs;
  static late String? themeMode;
  static late String? languageMode;
  static User? userInfo;

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

    languageMode = _prefs.getString(Constants.languageModeKey);
    if (languageMode == null) {
      await setLanguageMode(Constants.defaultLanguage);
      languageMode = Constants.defaultLanguage;
    }
    String? userJson = _prefs.getString(Constants.userkey);
    if (userJson != null && userJson.isNotEmpty) {
      userInfo = User.fromJson(jsonDecode(userJson));
      if (userInfo!.expirationTime.isBefore(DateTime.now())) {
        await logOut();
        return;
      }
    }
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

  static Future<void> saveInfoUser(User user) async {
    String jsonString = json.encode(user.toJson());
    await _prefs.setString(Constants.userkey, jsonString);
    userInfo = user;
  }

  static Future<void> logOut() async {
    await _prefs.remove(Constants.userkey);
    userInfo = null;
  }

 static Future<void> saveInvoice(List<Invoice> invoices) async {
    List<Map<String, dynamic>> jsonList = invoices.map((invoice) => invoice.toJson()).toList();
    String jsonString = json.encode(jsonList);
    await _prefs.setString(Constants.invoicekey, jsonString);
  }
  static Future<List<Invoice>> getStoredInvoices() async {
    final String? jsonString = _prefs.getString(Constants.invoicekey);

    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Invoice.fromJson(json)).toList();
    }
    return [];
  }
}

class Constants {
  static const String textLoad = "Đang tải";
  static const String textTitleError = "Lỗi";
  static const String textError =
      "Đã xảy ra lỗi khi tải dữ liệu. Vui lòng thử lại sau.";
  static const String textClose = "Đóng";
  static const String textReload = "Tải lại";
  static const String textEmpty = "Trống rỗng";

  static const String themeModeKey = "themeMode";
  static const String languageModeKey = "languageMode";
  static const String defaultTheme = darkPurpleTheme;
  static const String defaultLanguage = codeVNKey;
  static const String tokenKey = "token";
  static const String tokenExpirationKey = "tokenExpiration";
  static const String searchHistory = "searchHistory";
  static const String userkey = "user";
  static const String invoicekey = "invoice";

  static const String codeVNKey = 'vi'; // Vietnamese
  static const String codeENKey = 'en'; // English
  static const String codeFrench = 'fr'; // French
  static const String codeGerman = 'de'; // German
  static const String codeJapanese = 'ja'; // Japanese
  static const String codeRussian = 'ru'; // Russian

  static const String darkPurpleTheme = "dark_purple";
  static const String lightPurpleTheme = "light_purple";
  static const String darkBlueTheme = "dark_blue";
  static const String lightBlueTheme = "light_blue";
  static const String darkGreenTheme = "dark_green";
  static const String lightGreenTheme = "light_green";
  static const String darkRedTheme = "dark_red";
  static const String lightRedTheme = "light_red";
  static const String darkYellowTheme = "dark_yellow";
  static const String lightYellowTheme = "light_yellow";

  static final Map<String, String> themes = {
    darkPurpleTheme: "Chủ đề tối - Tím",
    lightPurpleTheme: "Chủ đề sáng - Tím",
    darkBlueTheme: "Chủ đề tối - Xanh lam",
    lightBlueTheme: "Chủ đề sáng - Xanh lam",
    darkGreenTheme: "Chủ đề tối - Xanh lá cây",
    lightGreenTheme: "Chủ đề sáng - Xanh lá cây",
    darkRedTheme: "Chủ đề tối - Đỏ",
    lightRedTheme: "Chủ đề sáng - Đỏ",
    darkYellowTheme: "Chủ đề tối - Vàng",
    lightYellowTheme: "Chủ đề sáng - Vàng",
  };

  static final Map<String, String> languages = {
    codeVNKey: "Tiếng Việt",
    codeENKey: "Tiếng Anh",
    //codeFrench: "Tiếng Pháp",
    // codeGerman: "Tiếng Đức",
    codeJapanese: "Tiếng Nhật",
    // codeRussian: "Tiếng Nga",
  };

  static final Map<String, String> flags = {
    codeVNKey: "vn",
    codeENKey: "us",
    //codeFrench: "fr",
    //codeGerman: "de",
    codeJapanese: "jp",
    // codeRussian: "ru",
  };
}
