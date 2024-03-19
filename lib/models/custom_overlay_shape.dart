import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CustomOverlayShape extends QrScannerOverlayShape {
  CustomOverlayShape();

  @override
  Rect getOverlayRect(Size screenSize, Size previewSize) {
    final scanAreaSize = screenSize.width * 0.7; // Kích thước của vùng quét
    final top = (screenSize.height - scanAreaSize) / 2;
    final left = (screenSize.width - scanAreaSize) / 2;

    return Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
      ),
    );
  }
}
