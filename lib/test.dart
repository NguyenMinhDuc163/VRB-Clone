import 'package:flutter/material.dart';

class MyGridView extends StatefulWidget {
  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  bool _showMore = false; // Trạng thái hiển thị thêm phần tử
  final List<Widget> _items = List.generate(
    6, // Số lượng phần tử ban đầu
        (index) => Container(
      color: Colors.blue[100 * (index % 9)],
      child: Center(
        child: Text('Item $index'),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Số cột trong GridView ban đầu
                crossAxisSpacing: 10, // Khoảng cách giữa các cột
                mainAxisSpacing: 10, // Khoảng cách giữa các hàng
              ),
              itemCount: _showMore ? _items.length : 6, // Số lượng phần tử được hiển thị
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print("da an");
                  },
                  child: _items[index],
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Xử lý khi ấn nút "Show More"
              setState(() {
                _showMore = true; // Đặt trạng thái hiển thị thêm là true
              });
            },
            child: Text('Show More'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyGridView(),
  ));
}
