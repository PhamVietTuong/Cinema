import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Styles.boldTextColor["dark_purple"], // Màu bạn muốn
            onPressed: () {
              Navigator.pop(this.context);
            },
          ),
          title: Text(
            "Cài đặt",
            style: TextStyle(
              fontSize: Styles.appbarFontSize,
              color: Styles.boldTextColor["dark_purple"],
            ),
          ),
          backgroundColor: Styles.backgroundContent["dark_purple"],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Styles.backgroundColor["dark_purple"],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: Styles.defaultHorizontal, vertical: 10),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Styles.backgroundContent["dark_purple"],
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language_outlined,
                          color: Styles.boldTextColor["dark_purple"],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Ngôn ngữ",
                          style: TextStyle(
                              fontSize: Styles.titleFontSize,
                              color: Styles.boldTextColor["dark_purple"]),
                        )
                      ],
                    ),
        
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: Styles.defaultHorizontal, vertical: 10),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Styles.backgroundContent["dark_purple"],
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language_outlined,
                          color: Styles.boldTextColor["dark_purple"],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Chế độ tối",
                          style: TextStyle(
                              fontSize: Styles.titleFontSize,
                              color: Styles.boldTextColor["dark_purple"]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
