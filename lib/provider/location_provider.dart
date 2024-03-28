import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../core/constants/assets_path.dart';
import '../models/bank_location.dart';
import '../models/district.dart';
import '../models/province.dart';
import '../network/netword_request.dart';

class LocationProvider extends ChangeNotifier{
  Map<String, Province> locations = {};
  Map<String, District> districts = {};
  List<Map<String, BankLocation>> address = [];
  String? provinceChose;
  String? districtChose;
  Set<Marker> markers = {};
  bool isLoading = false;
  final Location locationController = Location();
  LatLng currentLocation = LatLng(21.0014109, 105.8046842);
  int selectedButtonIndex = 0;
  int index = 0;
  GoogleMapController? mapController;
  Completer<GoogleMapController> controller = Completer();
  Set<Polyline> polylines = {};
  late BitmapDescriptor customMarker;

  void clearPolylines(){
    polylines.clear();
    notifyListeners();
  }
  void createPolylines(LatLng start, LatLng end) {
    polylines.clear(); // Xóa đường đi hiện tại
    List<LatLng> polylinePoints = [start, end];
    polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        color: Colors.red.shade600,
        points: polylinePoints,
        width: 5,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchData() async {
    isLoading = true; // Kích hoạt màn hình chờ
    try {
      locations = await DioTest.postProvinceInfoList();
      // address = await DioTest.postBranchATMTypeOne(currentLocation.longitude.toString(), currentLocation.latitude.toString());
      // TODO tam thoi goi type2 do 1 loi api
      address = await DioTest.postBranchATMTypeTwo(currentLocation.longitude.toString(), currentLocation.latitude.toString(), "101");

    } catch (error) {
      // Xử lý lỗi ở đây
      print(error);
    }
    isLoading = false;
    notifyListeners();
  }

  void createCustomMarker() {
    // Tạo biểu tượng từ hình ảnh tùy chỉnh
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)), AssetPath.logoBankVRB)
        .then((descriptor) {
        customMarker = descriptor;
        notifyListeners();
    });
  }

  Set<Marker> setMarkers(int index) {
    Set<Marker> markers = {};
    int markerIdCounter = 0;

    address[index].forEach((key, value) {
      double latitude = double.parse(value.latitude);
      double longitude = double.parse(value.longitude);
      Marker marker = Marker(
          markerId: MarkerId("location$markerIdCounter"),
          position: LatLng(latitude, longitude),
          infoWindow: InfoWindow(title: value.shotName, snippet: value.address),
          icon: customMarker
      );

      markers.add(marker);
      markerIdCounter++;
    });
    notifyListeners();
    return markers;
  }

  Future<void> getLocationUpdate() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if(serviceEnabled){
      serviceEnabled = await locationController.requestService();
    }else{
      return;
    }
    permissionGranted = await locationController.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await locationController.requestPermission();
      if(permissionGranted != PermissionStatus.granted){
        return;
      }
    }
    locationController.onLocationChanged.listen((LocationData currentLocationData) {
      if(currentLocationData.latitude != null && currentLocationData.longitude != null){
        currentLocation = LatLng(currentLocationData.latitude!, currentLocationData.longitude!);
        print('toa ho hien tai la $currentLocation');
        markers.add(
            Marker(
              markerId: MarkerId("current01"),
              // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              icon: BitmapDescriptor.defaultMarker,
              position: currentLocation ?? LatLng(21.005536, 105.8180681),
            )
        );
      }
    }
    );
    notifyListeners();
  }

  void setIndex(int x){
    index = x;
    notifyListeners();
  }
  void setSelectedButtonIndex(int x){
    selectedButtonIndex  = x;
    notifyListeners();
  }

  void setProvinceChose(String x){
    provinceChose = x;
    notifyListeners();
  }
  void setDistrictChose(String? x){
    districtChose = x;
    notifyListeners();
  }
  void setDistricts(Map<String, District> x){
    districts = x;
    notifyListeners();
  }

  void setAddress(List<Map<String, BankLocation>> x){
    address = x;
    notifyListeners();
  }

  void setMarker(Set<Marker> x){
    markers = x;
    notifyListeners();
  }
}