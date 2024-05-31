import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class MovieTypeBox extends StatelessWidget {
  const MovieTypeBox(
      {super.key,
      this.fontSizeCus = 0.0,
      this.maxBoxWith = 0.0,
      this.marginBottom = 0.0,
      this.padding = 0.0,
      this.marginTop = 0.0, required this.title});
  final String title;
  final double fontSizeCus;
  final double maxBoxWith;
  final double marginTop;
  final double marginBottom;
  final double padding;

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
     const gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF802FF7), Color(0xFFB654C3)],
  );
    return Container(
      margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
      constraints: maxBoxWith != 0.0
          ? BoxConstraints(maxWidth: maxBoxWith)
          : const BoxConstraints(),
    
      decoration: BoxDecoration(
        gradient: gradient,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(3.0),
         ),
      child:
      Container(
          padding: EdgeInsets.all(padding),
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
               color: const Color(0xFF272042),
          ),
     
        child:Text(
        title,
        style: fontSizeCus != 0.0
            ? styles.normalTextStyle.copyWith(fontSize: fontSizeCus,color: Colors.white)
            : styles.normalTextStyle,
      ), 
      )
       
    );
  }
}
