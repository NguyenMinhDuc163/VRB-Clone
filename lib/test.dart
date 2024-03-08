// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class YourMapWidget extends StatelessWidget {
//   final List<Map<String, Point>> address;
//
//   const YourMapWidget({Key? key, required this.address}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     int markerIdCounter = 0; // Biến đếm để tạo markerId tự tăng
//
//     // Tạo danh sách các Marker từ address
//     Set<Marker> markers = address.map((data) {
//       Point point = data['point'] ?? Point(0, 0);
//       String markerId = 'marker_$markerIdCounter'; // Tạo markerId tự tăng
//
//       markerIdCounter++; // Tăng biến đếm cho lần tạo marker tiếp theo
//       return Marker(
//         markerId: MarkerId(markerId),
//         icon: BitmapDescriptor.defaultMarker,
//         position: LatLng(point.latitude, point.longitude),
//       );
//     }).toSet();
//
//     return GoogleMap(
//       initialCameraPosition: const CameraPosition(
//         target: LatLng(21.005536, 105.8180681),
//         zoom: 5,
//       ),
//       markers: markers,
//     );
//   }
// }
//
// // Point class for demonstration purpose
// class Point {
//   final double latitude;
//   final double longitude;
//
//   Point(this.latitude, this.longitude);
// }
//
// void main() {
//   List<Map<String, Point>> address = [
//     {'point': Point(10.46425, 106.41252)},
//     {'point': Point(21.02206, 105.84805)},
//     {'point': Point(16.06061, 108.21437)},
//     {'point': Point(12.25141, 109.18795)},
//   ];
//
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: YourMapWidget(address: address),
//     ),
//   ));
// }
