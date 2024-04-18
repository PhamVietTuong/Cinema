import 'package:flutter/material.dart';

class BtnUpDown extends StatelessWidget {
  const BtnUpDown({super.key, this.isUp = false, this.colorText=Colors.black});
  final bool isUp;
  final Color? colorText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: colorText!), borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        child: Icon(isUp ? Icons.add : Icons.remove, color: colorText,),
      ),
    );
  }
}
