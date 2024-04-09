import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/dimension_constants.dart';

class SearchListBankWidget extends StatefulWidget {
  const SearchListBankWidget({super.key});

  @override
  State<SearchListBankWidget> createState() => _SearchListBankWidgetState();
}

class _SearchListBankWidgetState extends State<SearchListBankWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextField(
        style: const TextStyle(fontSize: 14, color: Colors.black87), // mau chu khi nguoi dung nhap
        decoration:  InputDecoration(
          hintText: 'Tìm kiếm danh sách',
          hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
          labelStyle: TextStyle(fontSize: 14, color: Colors.white),
          prefixIcon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.black38,
              size: 24,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
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
      ),
    );
  }
}
