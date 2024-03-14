// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MapScreen(),
//     );
//   }
// }
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController mapController;
//   BitmapDescriptor customMarker;
//
//   @override
//   void initState() {
//     super.initState();
//     // Tạo biểu tượng tùy chỉnh cho marker
//     createCustomMarker();
//   }
//
//   void createCustomMarker() {
//     // Tạo biểu tượng từ hình ảnh tùy chỉnh
//     BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(48, 48)), 'assets/custom_marker.png')
//         .then((descriptor) {
//       setState(() {
//         customMarker = descriptor;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Marker Example'),
//       ),
//       body: GoogleMap(
//         onMapCreated: (controller) {
//           setState(() {
//             mapController = controller;
//           });
//         },
//         initialCameraPosition: CameraPosition(
//           target: LatLng(37.42796133580664, -122.085749655962),
//           zoom: 15,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('marker_1'),
//             position: LatLng(37.42796133580664, -122.085749655962),
//             icon: customMarker, // Sử dụng biểu tượng tùy chỉnh ở đây
//             onTap: () {
//               // Xử lý sự kiện khi marker được chạm vào
//             },
//           ),
//         },
//       ),
//     );
//   }
// }
