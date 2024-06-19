import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinema_app/components/bottom_nav.dart';
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Config.initialize();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
class MyApp extends StatelessWidget {
  final String initialLanguageCode;

  const MyApp({Key? key, required this.initialLanguageCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema App',
      debugShowCheckedModeBanner: false,
      locale: Locale(initialLanguageCode),
      supportedLocales: const [
        Locale('en'),
        Locale('vi'),
      ],
      home: const BottomNav(),
    );
  }
}
