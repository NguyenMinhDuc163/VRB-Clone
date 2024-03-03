import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrb_client/core/constants/assets_path.dart';

class SelectItemWidget extends StatefulWidget {
  const SelectItemWidget({super.key, required this.selectedValue});
  final String selectedValue;
  @override
  State<SelectItemWidget> createState() => _SelectItemWidgetState();
}

class _SelectItemWidgetState extends State<SelectItemWidget> {
  final List<String> items = ['100068890', '123456789', '987654321'];
  late String selectedValue = widget.selectedValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 122,
      height: 30,
      child: DropdownButton<String>(
        value: selectedValue,
        isExpanded: true,
        underline: Container(),
        icon: Image.asset(AssetPath.icoDownBlack),
        onChanged: (String? newValue) {
          // Khi giá trị được chọn thay đổi
          if (newValue != null) {
            // Cập nhật giá trị đã chọn
            setState(() {
              selectedValue = newValue;
            });
          }
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );;
  }
}
