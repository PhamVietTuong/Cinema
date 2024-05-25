import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrBox extends StatelessWidget {
  const QrBox({super.key, required this.value, this.size=100.0});
  final double size;
  final String value;
  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: value,
      size: size,
      version: QrVersions.auto,
    );
  }
}
