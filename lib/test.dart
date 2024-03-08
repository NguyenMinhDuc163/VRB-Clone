import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DropdownExample(),
    );
  }
}

class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  late String selectedProvince;
  late String selectedDistrict;

  List<String> provinces = ['Tỉnh A', 'Tỉnh B']; // Danh sách tỉnh
  Map<String, List<String>> districts = { // Danh sách huyện theo từng tỉnh
    'Tỉnh A': ['Huyện A1', 'Huyện A2'],
    'Tỉnh B': ['Huyện B1', 'Huyện B2']
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              hint: Text('Chọn tỉnh'),
              value: selectedProvince,
              onChanged: (String newValue) {
                setState(() {
                  selectedProvince = newValue;
                  selectedDistrict = null; // Reset huyện khi chọn tỉnh mới
                });
              },
              items: provinces.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Chọn huyện'),
              value: selectedDistrict,
              onChanged: selectedProvince == null
                  ? null
                  : (String newValue) {
                setState(() {
                  selectedDistrict = newValue;
                });
              },
              items: selectedProvince == null
                  ? null
                  : districts[selectedProvince].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
