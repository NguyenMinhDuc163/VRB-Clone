import 'package:flutter/material.dart';

class SelectLocalWidget extends StatefulWidget {
  const SelectLocalWidget({Key? key, required this.selectedValue, required this.items}) : super(key: key);

  final List<String> items;
  final String selectedValue;

  @override
  State<SelectLocalWidget> createState() => _SelectLocalWidgetState(selectedValue);
}

class _SelectLocalWidgetState extends State<SelectLocalWidget> {
  late String selectedValue;

  _SelectLocalWidgetState(this.selectedValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), // Độ cong của góc
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Màu và độ trong suốt của bóng
            spreadRadius: 5, // Độ rộng của bóng
            blurRadius: 7, // Độ mờ của bóng
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: DropdownButton<String>(
        underline: Container(),
        isExpanded: true,
        value: selectedValue,
        style: const TextStyle(
          fontSize: 16, // Kích thước chữ
          color: Colors.black, // Màu chữ
          fontWeight: FontWeight.bold
        ),
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(

            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            // Cập nhật giá trị đã chọn
            setState(() {
              selectedValue = newValue;
            });
          }
        },
      ),
    );
  }
}
