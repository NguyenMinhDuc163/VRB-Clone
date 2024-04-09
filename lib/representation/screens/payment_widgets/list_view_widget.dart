import 'package:flutter/material.dart';
import '../../../core/constants/assets_path.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});
  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final List<String> imagePaths = [
    AssetPath.logoBank1,
    AssetPath.logoBank2,
    AssetPath.logoBank3,
    AssetPath.logoBank4,
    AssetPath.logoBank5,
    AssetPath.logoBank6,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Đặt chiều cao cho container
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2), // Giảm kích thước padding để làm cho các icon gần nhau hơn
            child: IconButton(onPressed: () {  
              print("da an");
            }, icon: Image.asset(
              imagePaths[index],
              width: 50, // Điều chỉnh chiều rộng của ảnh để phù hợp với UI
            ),
              
            ),
          );
        },
      ),
    );
  }
}
