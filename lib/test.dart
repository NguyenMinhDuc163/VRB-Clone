import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              _loading = true;
            });
            _showLoadingDialog();
            // Simulate a time-consuming operation
            await Future.delayed(Duration(seconds: 2));
            setState(() {
              _loading = false;
            });
            _hideLoadingDialog();
          },
          child: Text('Show Loading'),
        ),
      ),
    );
  }
}
