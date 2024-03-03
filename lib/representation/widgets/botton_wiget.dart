
import 'package:flutter/material.dart';

import '../../core/constants/dimension_constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.title, this.onTap});
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF19226D),
                Color(0xFFED1C24),
              ],
              stops: [0.5, 1],
            ),
            borderRadius: BorderRadius.circular(kMediumPadding),
        ),
        alignment: Alignment.center,
        child: Text(title, style: TextStyle(fontSize: 14, color: Colors.white),),
        ),
      );
  }
}
