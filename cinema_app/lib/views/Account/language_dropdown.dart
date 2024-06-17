import 'package:cinema_app/config.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({Key? key}) : super(key: key);

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  @override
  Widget build(BuildContext context) {
    final locale = EasyLocalization.of(context)?.locale ?? Locale('en');

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        DropdownButton<String>(
          value: locale.languageCode,
          onChanged: (String? newValue) {
            setState(() {
              EasyLocalization.of(context)?.setLocale(Locale(newValue!));
            });
          },
          dropdownColor: Styles.backgroundContent["dark_purple"],
          underline: Container(),
          icon: Icon(Icons.keyboard_arrow_right,),
             // color: Styles.boldTextColor["dark_purple"]),
          items: <String>['en', 'vi']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value == 'vi' ? 'English' : 'Tiếng Việt',
               // style: TextStyle(color: Styles.boldTextColor["dark_purple"]),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
