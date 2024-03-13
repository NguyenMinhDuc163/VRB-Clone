// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   Completer<GoogleMapController> _controller = Completer();
//   static const LatLng _startPoint = LatLng(21.005536, 105.8180681);
//   static const LatLng _endPoint = LatLng(21.0278, 105.8345);
//
//   Set<Marker> _markers = Set<Marker>();
//   Set<Polyline> _polylines = Set<Polyline>();
//
//   @override
//   void initState() {
//     super.initState();
//     _markers.add(
//       Marker(
//         markerId: MarkerId('start_point'),
//         position: _startPoint,
//         infoWindow: InfoWindow(title: 'Start Point'),
//       ),
//     );
//     _markers.add(
//       Marker(
//         markerId: MarkerId('end_point'),
//         position: _endPoint,
//         infoWindow: InfoWindow(title: 'End Point'),
//       ),
//     );
//     _createPolylines(_startPoint, _endPoint);
//   }
//
//   void _createPolylines(LatLng start, LatLng end) {
//     List<LatLng> polylinePoints = [start, end];
//     _polylines.add(
//       Polyline(
//         polylineId: PolylineId('route'),
//         color: Colors.blue,
//         points: polylinePoints,
//         width: 5,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map with Route'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(target: _startPoint, zoom: 12),
//         markers: _markers,
//         polylines: _polylines,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }
