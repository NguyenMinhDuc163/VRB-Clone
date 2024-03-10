import 'package:flutter/material.dart';

class SelectLocalWidget extends StatefulWidget {
  const SelectLocalWidget({Key? key, required this.selectedValue, required this.items, required this.onChanged, this.onValueChanged, this.defaultHint}) : super(key: key);
  final ValueChanged<String?> onChanged;
  final ValueChanged<String?>? onValueChanged;
  final List<String> items;
  final String? selectedValue;
  final String? defaultHint;

  @override
  State<SelectLocalWidget> createState() => _SelectLocalWidgetState();
}

class _SelectLocalWidgetState extends State<SelectLocalWidget> {


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
        value: widget.selectedValue,
        hint: widget.selectedValue == null
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.defaultHint ?? 'Select an option'),
            )
            : null,
        style: const TextStyle(
          fontSize: 16, // Kích thước chữ
          color: Colors.black, // Màu chữ
          fontWeight: FontWeight.bold
        ),
        onChanged: (newValue) {
          widget.onChanged(newValue); // Gọi onChanged để cập nhật giá trị được chọn
          widget.onValueChanged?.call(newValue); // Gọi callback để chuyển giá trị cho dropdown thứ hai
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(

            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ),
          );
        }).toList(),

      ),
    );
  }
}
