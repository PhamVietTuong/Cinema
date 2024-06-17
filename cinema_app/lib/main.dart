import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cinema_app/components/bottom_nav.dart';
import 'package:cinema_app/views/Account/mode_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  final themeService=await ThemeService.instance;
  var initTheme=themeService.initial;
  runApp( MyApp(theme: initTheme,));
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
  const MyApp({super.key, required this.theme});
  final ThemeData theme;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return ThemeProvider(initTheme: theme,
   builder: (_, theme)
   {
     return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const BottomNav(),
    );
   },
   );
  }
}