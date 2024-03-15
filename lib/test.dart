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
          title: Text('Table Example'),
        ),
        body: Center(
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text('Column 1')),
              DataColumn(label: Text('Column 2')),
              DataColumn(label: Text('Column 3')),
              DataColumn(label: Text('Column 4')),
            ],
            rows: <DataRow>[
              DataRow(cells: <DataCell>[
                DataCell(Text('Data 1')),
                DataCell(Text('Data 2')),
                DataCell(Text('Data 3')),
                DataCell(Text('Data 4')),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('Data 5')),
                DataCell(Text('Data 6')),
                DataCell(Text('Data 7')),
                DataCell(Text('Data 8')),
              ]),
              // Thêm các DataRow khác tại đây cho dữ liệu khác
            ],
          ),
        ),
      ),
    );
  }
}
