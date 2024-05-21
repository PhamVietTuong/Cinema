import 'package:flutter/material.dart';

var serverUrl = 'http://192.168.1.37:3000';

class Styles {
  var primaryColor = Colors.purple[700];
  var soldColor = Colors.grey;
  var coupleSeatColor = Colors.green;
  var singleSeatColor = Colors.amber;
  var selectedSeatColor = Colors.lightBlue;
  var waitingSeatColor = Colors.deepOrangeAccent;


  var borderWith = Border.all(width: 1);
  var appBarTextStyle = const TextStyle(
    fontSize: 25,
  );
  var titleTextStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  var normalTextStyle = const TextStyle(fontSize: 15);
  var iconSizeInLineText = 18.0;
  var iconSizeInTitle = 30.0;

  //nhu y
  var gadientColorToptoBot = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(150, 0, 87, 146),
      Color.fromARGB(255, 7, 13, 45),
    ],
  );
}
