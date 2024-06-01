import 'package:cinema_app/config.dart';
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
               
                ),
                Text(
                  "23",
              
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
     
            ),
          ),
        ],
      ),
    );
  }
}
