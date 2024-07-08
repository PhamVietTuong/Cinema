import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SendAuthCode extends StatefulWidget {
 const SendAuthCode({super.key, required this.code});
 final String code;

  @override
  // ignore: library_private_types_in_public_api
  _SendAuthCodeState createState() => _SendAuthCodeState();
}
class _SendAuthCodeState extends State<SendAuthCode> {
  TextEditingController _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Styles.boldTextColor[Config.themeMode],
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Xác thực",
          style: TextStyle(
            fontSize: Styles.appbarFontSize,
            color: Styles.boldTextColor[Config.themeMode],
          ),
        ),
        backgroundColor: Styles.backgroundContent[Config.themeMode],
      ),
      backgroundColor: Styles.backgroundColor[Config.themeMode],
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: Styles.defaultHorizontal, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Vui lòng nhập mã OTP gửi về email của bạn để xác nhận",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Styles.titleFontSize,
                color: Styles.titleColor[Config.themeMode],
              ),
            ),
            const SizedBox(height: 15.0),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Mã số xác nhận',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text(
                'Xác nhận',
                style: TextStyle(fontSize: Styles.titleFontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
