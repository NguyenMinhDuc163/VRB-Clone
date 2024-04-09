import 'package:flutter/material.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';

class RowBottonWidget extends StatefulWidget {
  const RowBottonWidget({super.key});

  @override
  State<RowBottonWidget> createState() => _RowBottonWidgetState();
}

class _RowBottonWidgetState extends State<RowBottonWidget> {
  int selectButton = 0;
  Widget _buildButton(String title, VoidCallback onPressed, int index){

    return GestureDetector(
      onTap: () {
        setState(() {
          selectButton = index;
        });
        onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300), // Thời gian chuyển đổi
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: index == selectButton ? Colors.grey.withOpacity(0.3) : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 12, color: index == selectButton ? Colors.blue : Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade50,
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      child: Row(
        children: [
          Expanded(child: _buildButton("Danh sách NTH", () { }, 0)),
          Expanded(child: _buildButton("Gần đây", () { }, 1)),
          Expanded(child: _buildButton("mẫu lưu", () { }, 2)),
        ],
      ),
    );
  }
}
