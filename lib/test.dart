import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Get Keyboard Height'),
        ),
        body: GetKeyboardHeightDemo(),
      ),
    );
  }
}

class GetKeyboardHeightDemo extends StatefulWidget {
  @override
  _GetKeyboardHeightDemoState createState() => _GetKeyboardHeightDemoState();
}

class _GetKeyboardHeightDemoState extends State<GetKeyboardHeightDemo> {
  double keyboardHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(_keyboardListener);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(_keyboardListener);
    super.dispose();
  }

  void _keyboardListener() {
    final double newHeight = MediaQuery.of(context).viewInsets.bottom;
    setState(() {
      keyboardHeight = newHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            hintText: 'Tap here to show keyboard',
          ),
          onTap: () {
            // Do something when the text field is tapped
          },
        ),
        SizedBox(height: 20),
        Text(
          'Keyboard height: ${keyboardHeight.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
