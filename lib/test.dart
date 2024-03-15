import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      _showPermissionDeniedDialog();
    }
  }

  Future<void> _showPermissionDeniedDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Quyền truy cập bị từ chối"),
          content: Text("Ứng dụng cần quyền truy cập vị trí để hiển thị bản đồ."),
          actions: <Widget>[
            FloatingActionButton(
              child: Text("Đóng"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FloatingActionButton(
              child: Text("Cài đặt"),
              onPressed: () {
                openAppSettings(); // Mở màn hình cài đặt vị trí của thiết bị
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Center(
        child: Text('Google Map will be displayed here'),
      ),
    );
  }
}
