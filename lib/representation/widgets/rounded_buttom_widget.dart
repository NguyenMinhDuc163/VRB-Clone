import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundedButtomWidget extends StatelessWidget {
  const RoundedButtomWidget({super.key, required this.isSelected, required this.icon, required this.onPressed});
  final bool isSelected;
  final IconData icon;
  final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF19226D).withOpacity(0.9),
              Color(0xFFED1C24).withOpacity(0.8),
            ],
            stops: [0.5, 1],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70.withOpacity(0.2), // Đổi màu nền ở đây
                padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10), // Có thể thêm các thuộc tính khác nếu cần
                shape: RoundedRectangleBorder(
                  // Tạo hình dạng chữ nhật
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Gần nhất",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "ATM",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70.withOpacity(0.2), // Đổi màu nền ở đây
                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10), // Có thể thêm các thuộc tính khác nếu cần
                shape: RoundedRectangleBorder(
                  // Tạo hình dạng chữ nhật
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Chi nhánh",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70.withOpacity(0.2), // Đổi màu nền ở đây
                padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10), // Có thể thêm các thuộc tính khác nếu cần
                shape: RoundedRectangleBorder(
                  // Tạo hình dạng chữ nhật
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
