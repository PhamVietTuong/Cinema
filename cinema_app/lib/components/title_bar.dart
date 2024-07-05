import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatefulWidget {
  const TitleBar({super.key, required this.title});
  final String title;

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  late String textTitle;
  void tranlate()async{
    List<String> textTranlate=await Future.wait([
      Styles.translate(textTitle),
    ]);
    textTitle=textTranlate[0];
    setState(() {
      
    });
  }
  @override
  void initState() {
    super.initState();
    textTitle = widget.title;
    tranlate();
  }

  @override
  Widget build(BuildContext context) {
    var wS = MediaQuery.of(context).size.width;
    return Container(
      width: wS,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration:
          BoxDecoration(color: Styles.backgroundContent[Config.themeMode]),
      child: Center(
        child: Text(
          textTitle.toUpperCase(),
          style: TextStyle(
              fontSize: 20, color: Styles.titleColor[Config.themeMode]),
        ),
      ),
    );
  }
}
