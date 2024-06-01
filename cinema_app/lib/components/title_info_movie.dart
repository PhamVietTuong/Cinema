import 'package:flutter/material.dart';

class TitleInfoMovie extends StatelessWidget {
  TitleInfoMovie({super.key, required this.title});
  var title;

  @override
  Widget build(BuildContext context) {
    return  Container(
                width: MediaQuery.of(context).size.width/4-5,
                child: Text(title , style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF774ECB),),)
    );
  }
}
