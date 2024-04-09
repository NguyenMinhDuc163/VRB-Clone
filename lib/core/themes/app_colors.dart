import 'package:flutter/material.dart';

class AppColor{
  static const grayColor = Color(0x0ff2f2f2);
  static const WhiteColor = Color(0x0ff4f7fe);
  static const BlueColor = Color(0xff002D85);
  static LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xFF19226D).withOpacity(0.9),
      const Color(0xFFED1C24).withOpacity(0.8),
    ],
    stops: [0.5, 1],
  );
}