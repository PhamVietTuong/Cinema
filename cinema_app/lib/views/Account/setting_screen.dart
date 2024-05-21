import 'package:cinema_app/constants.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var styles = Styles();
  int _selectedLanguageIndex = 0; 
  List<String> languages = ['Tiếng Việt', 'Tiếng Anh'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Cấu hình",
          style: styles.titleTextStyle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700) 
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 2,
            color: const Color.fromARGB(255, 211, 211, 211),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ngôn Ngữ",
                  style: styles.titleTextStyle
                      .copyWith(fontSize: 18, color: Colors.black54),
                ),
                ToggleButtons(
                  isSelected: [
                    _selectedLanguageIndex == 0,
                    _selectedLanguageIndex == 1
                  ],
                  onPressed: (index) {
                    setState(() {
                      _selectedLanguageIndex = index;
                    });
                  },
                  children: const [
                    Text("Tiếng Việt"),
                    Text("Tiếng Anh"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 5,
            color: const Color.fromARGB(255, 211, 211, 211),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phiên Bản",
                  style: styles.titleTextStyle
                      .copyWith(fontSize: 18, color: Colors.black54),
                ),
                Text(
                  "23",
                  style: styles.titleTextStyle
                      .copyWith(fontSize: 18, color: Colors.black54),
                )
              ],
            ),
          ),
          Container(
            height: 5,
            color: const Color.fromARGB(255, 211, 211, 211),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Giới thiệu ứng dụng cho bạn bè",
                  style: styles.titleTextStyle
                      .copyWith(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            height: 5,
            color: const Color.fromARGB(255, 211, 211, 211),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Xóa tài khoản",
              style: styles.titleTextStyle
                  .copyWith(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
