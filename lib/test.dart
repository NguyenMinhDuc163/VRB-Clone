import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyRadioPage(),
    );
  }
}

class MyRadioPage extends StatefulWidget {
  @override
  _MyRadioPageState createState() => _MyRadioPageState();
}

class _MyRadioPageState extends State<MyRadioPage> {
  String selectedOption = 'Option 1';

  setSelectedOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Button Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RadioListTile(
              title: Text('Option 1'),
              value: 'Option 1',
              groupValue: selectedOption,
              onChanged: (value) {
                setSelectedOption(value!);
              },
            ),
            RadioListTile(
              title: Text('Option 2'),
              value: 'Option 2',
              groupValue: selectedOption,
              onChanged: (value) {
                setSelectedOption(value!);
              },
            ),
            RadioListTile(
              title: Text('Option 3'),
              value: 'Option 3',
              groupValue: selectedOption,
              onChanged: (value) {
                setSelectedOption(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
