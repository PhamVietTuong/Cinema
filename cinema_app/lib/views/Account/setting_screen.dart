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
            color: Styles.boldTextColor[Config.themeMode], // Màu bạn muốn
            onPressed: () {
              Navigator.pop(this.context);
            },
          ),
          title: Text(
            "Cài đặt",
            style: TextStyle(
              fontSize: Styles.appbarFontSize,
              color: Styles.boldTextColor[Config.themeMode],
            ),
          ),
          backgroundColor: Styles.backgroundContent[Config.themeMode],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Styles.backgroundColor[Config.themeMode],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: Styles.defaultHorizontal, vertical: 10),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Styles.backgroundContent[Config.themeMode],
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
                          color: Styles.boldTextColor[Config.themeMode],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Ngôn ngữ",
                          style: TextStyle(
                              fontSize: Styles.titleFontSize,
                              color: Styles.boldTextColor[Config.themeMode]),
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
                  color: Styles.backgroundContent[Config.themeMode],
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
                child: DropdownButton(
                    value: Config.themeMode,
                    dropdownColor: Styles.backgroundContent[Config.themeMode],
                    style: TextStyle(
                        color: Styles.boldTextColor[Config.themeMode],
                        fontSize: Styles.titleFontSize),
                    isExpanded: true,
                    items: Constants.themes.entries
                        .map((e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ))
                        .toList(),
                    onChanged: (e) {
                      setState(() {
                        Config.setThemeMode(e!);
                      });
                    }),
              ),
            ]),
          ),
        ));
  }
}
