import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cinema_app/config.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({Key? key}) : super(key: key);

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  @override
  Widget build(BuildContext context) {
    final locale = EasyLocalization.of(context)?.locale ?? const Locale('en');

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        DropdownButton<String>(
          value: locale.languageCode,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                EasyLocalization.of(context)?.setLocale(Locale(newValue!));
              });
            }
          },
          dropdownColor: Styles.backgroundContent["dark_purple"], // Cần đảm bảo Styles.backgroundContent["dark_purple"] đã được định nghĩa trong config.dart
          underline: Container(),
          icon: const Icon(Icons.keyboard_arrow_right),
          items: <String>['en', 'vi']
              .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'vi' ? 'English' : 'Tiếng Việt'),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
