import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KeyboardHeightExample(),
    );
  }
}

class KeyboardHeightExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context) giúp truy cập vào thông tin media query của context hiện tại
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        title: Text('Keyboard Height Example'),
      ),
      body: Column(
        children: [
          TextField(),
          Center(
            // Hiển thị chiều cao của bàn phím hoặc thông báo khi không có bàn phím
            child: Text(
              keyboardHeight > 0 ? 'Keyboard Height: $keyboardHeight' : 'No Keyboard Detected',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
