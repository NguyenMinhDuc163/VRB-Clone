import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard Visibility',
      home: KeyboardVisibilityExample(),
    );
  }
}

class KeyboardVisibilityExample extends StatefulWidget {
  @override
  _KeyboardVisibilityExampleState createState() =>
      _KeyboardVisibilityExampleState();
}

class _KeyboardVisibilityExampleState extends State<KeyboardVisibilityExample> with WidgetsBindingObserver {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final keyboardVisible = isKeyboardVisible();
    if (keyboardVisible) {
      print('Keyboard is visible');
    } else {
      print('Keyboard is not visible');
    }
  }

  bool isKeyboardVisible() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return bottomInset > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keyboard Visibility'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Tap here to bring up the keyboard',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
