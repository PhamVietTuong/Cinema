import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class TextFieldController extends StatefulWidget {
   TextFieldController({super.key, required this.textController, required this.textName, required this.status});
  final String textController;
  final String textName;
  final bool status;

  @override
  State<TextFieldController> createState() => _InfoTextFiedState();
}

class _InfoTextFiedState extends State<TextFieldController> {
  late TextEditingController _controller;
  late String textNameTranlate;
  
  void translate() async {
    List<String> textTranslate = await Future.wait([
      Styles.translate(textNameTranlate),
    ]);
    textNameTranlate=textTranslate[0];
    setState(() {});
  }

  void text() {
    _controller = TextEditingController(text: widget.textController);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    text();
    textNameTranlate=widget.textName;
    translate(); // Gọi hàm translate
  }

  @override
  void dispose() {
    _controller.dispose(); // Giải phóng bộ nhớ khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _controller,
                  style: TextStyle(
                    color: Styles.boldTextColor[Config.themeMode],
                    fontSize: Styles.titleFontSize,
                  ),
                  readOnly: widget.status,
                  decoration: InputDecoration(
                    border: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: textNameTranlate,
                    labelStyle: TextStyle(
                      color: Styles.boldTextColor[Config.themeMode], 
                      fontSize: Styles.iconSizeInLineText,
                    ),
                  ),
                ),
              );
  }
}