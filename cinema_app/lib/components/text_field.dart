import 'package:flutter/material.dart';
import 'package:cinema_app/config.dart'; // Đảm bảo import đúng

// ignore: must_be_immutable
class InfoTextField extends StatefulWidget {
   InfoTextField({
    Key? key,
    // controller
    required this.textController,
    //Icon leading ở textfield
    required this.icon,
    //Tiêu đề lableTitle của textfield
     this.lableText="",
    //Trạng thái có dc chỉnh sửa hay không
     this.readOnly=false,
    // Mật khẩu
     this.obscurePassword=false,
    this.onTap
  }) : super(key: key);

  final TextEditingController textController;
  final String lableText;
  final Icon icon;
  final bool readOnly;
  final bool obscurePassword;
  Function()? onTap;

  @override
  State<InfoTextField> createState() => _InfoTextFieldState();
}

class _InfoTextFieldState extends State<InfoTextField> {
  late String textTitle;
  bool _isObscure = false;

  @override
  void initState() {
    super.initState();
    textTitle = widget.lableText;
    _isObscure = widget.obscurePassword;
    tranlate();
  }

  Future<void> tranlate() async {
    List<String> textTranlate = await Future.wait([
      Styles.translate(textTitle),
    ]);
    setState(() {
      textTitle = textTranlate[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      controller: widget.textController,
      style: TextStyle(
        color: Styles.boldTextColor[Config.themeMode],
        fontSize: Styles.titleFontSize,
      ),
      obscureText: _isObscure, // Sử dụng biến trạng thái
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: textTitle,
        labelStyle: TextStyle(
          color: Styles.boldTextColor[Config.themeMode],
          fontSize: Styles.iconSizeInLineText,
        ),
        prefixIcon: widget.icon,
        suffixIcon: widget.obscurePassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                child: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Styles.boldTextColor[Config.themeMode],
                ),
              )
            : null,
      ),
    );
  }
}
