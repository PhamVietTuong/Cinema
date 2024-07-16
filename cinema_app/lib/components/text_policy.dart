import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class TextPolicy extends StatefulWidget {
  TextPolicy({super.key, required this.title});
  var title;

  @override
  State<TextPolicy> createState() => _TextPolicyState();
}

class _TextPolicyState extends State<TextPolicy> {
 late String textTitle;
 void tranlate() async
 {
  List<String> textTranlate= await Future.wait(
   [
    Styles.translate(textTitle),
   ]
  );
    textTitle=textTranlate[0];
    setState(() {
      
    });
 }
 @override
  void initState() {
    super.initState();
    textTitle=widget.title;
    tranlate();
  }
  @override
  Widget build(BuildContext context) {
    return      TextButton(
              onPressed: () {},
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                 textTitle, style: TextStyle(
                  fontSize: Styles.titleFontSize,
                  color: Styles.boldTextColor[Config.themeMode ]
                 ),
                  ),
               Icon(Icons.arrow_forward_ios_rounded, color:Styles.boldTextColor[Config.themeMode ]),
                ],
              ),
            );
  }
}