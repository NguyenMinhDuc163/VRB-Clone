import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/dimension_constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 14, color: Colors.white70), // mau chu khi nguoi dung nhap
      decoration: const InputDecoration(
        hintText: 'Tìm kiếm chức năng',
        hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
        labelStyle: TextStyle(fontSize: 14, color: Colors.white),
        suffixIcon: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.white60,
            size: 24,
          ),
        ),
        filled: true,
        fillColor: Colors.black12,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(
              kItemPadding,
            ),
          ),
        ),
        contentPadding:
        EdgeInsets.symmetric(horizontal: kItemPadding),
      ),
      // style: TextStyles.defaultStyle,
      onChanged: (value) {},
      onSubmitted: (String submitValue) {},
    );
  }
}
