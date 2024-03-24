

import 'dart:async';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../core/constants/assets_path.dart';
import '../../core/constants/dimension_constants.dart';
import '../../models/bank_location.dart';
import '../../models/distance_point.dart';
import '../../models/district.dart';
import '../../models/province.dart';
import '../../network/netword_request.dart';
import '../../provider/dialog_provider.dart';
import '../widgets/address_form_widget.dart';
import '../widgets/select_local_widget.dart';
import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});
  static String routeName = '/location_screen';
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();
  Map<String, Province> locations = {};
  Map<String, District> districts = {};
  List<Map<String, BankLocation>> address = [];
  String? provinceChose;
  String? districtChose;
  Set<Marker> markers = {};
  bool _isLoading = false;
  final Location _locationController = Location();
  LatLng _currentLocation = LatLng(21.0014109, 105.8046842);
  int selectedButtonIndex = 0;
  int index = 0;
  GoogleMapController? mapController;
  Completer<GoogleMapController> _controller = Completer();
   Set<Polyline> _polylines = {};
  late BitmapDescriptor customMarker;

  void _createPolylines(LatLng start, LatLng end) {
    setState(() {
      _polylines.clear(); // Xóa đường đi hiện tại
      List<LatLng> polylinePoints = [start, end];
      _polylines.add(
        Polyline(
          polylineId: PolylineId('route'),
          color: Colors.red.shade600,
          points: polylinePoints,
          width: 5,
        ),
      );
    });
  }
  void initState() {
    super.initState();
    fetchData(); // Gọi fetchData khi trang được khởi tạo
    getLocationUpdate();
    createCustomMarker();
    _requestPermission();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true; // Kích hoạt màn hình chờ
    });

    try {
      locations = await DioTest.postProvinceInfoList();
      // address = await DioTest.postBranchATMTypeOne(_currentLocation.longitude.toString(), _currentLocation.latitude.toString());
      // TODO tam thoi goi type2 do 1 loi api
      address = await DioTest.postBranchATMTypeTwo(_currentLocation.longitude.toString(), _currentLocation.latitude.toString(), "101");

    } catch (error) {
      // Xử lý lỗi ở đây
    }

    setState(() {
      _isLoading = false; // Tắt màn hình chờ
    });
  }

  void createCustomMarker() {
    // Tạo biểu tượng từ hình ảnh tùy chỉnh
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)), AssetPath.logoBankVRB)
        .then((descriptor) {
      setState(() {
        customMarker = descriptor;
      });
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
    return markers;
  }
  //TODO test truong hop user khong cho phep truy cap local
  Future<void> _requestPermission() async {
    final hasPermission = await _locationController.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      // Hiển thị hướng dẫn hoặc thông báo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Quyền truy cập bị từ chối"),
            content: Text("Ứng dụng cần quyền truy cập để hiển thị bản đồ."),
            actions: <Widget>[
              FloatingActionButton  (
                child: Text("Đóng"),
                onPressed: () {
                  // chuyen huong nguoi
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ScrollController scrollController = ScrollController();


    double distanceBetween(String latitude, String longitude){
      return Geolocator.distanceBetween
        (_currentLocation.latitude, _currentLocation.longitude, double.parse(latitude), double.parse(longitude));
    }

    List<Map<String, BankLocation>> sortMap(List<Map<String, BankLocation>> newAddresses)  {
      for(int i = 0; i < newAddresses.length; i++){
        List<MapEntry<String, BankLocation>> entries = newAddresses[i].entries.toList();
        entries.sort((a, b) => distanceBetween(a.value.latitude, a.value.longitude).compareTo(distanceBetween(b.value.latitude, b.value.longitude)));
        Map<String, BankLocation> sortedMap = Map.fromEntries(entries);
        newAddresses[i] = sortedMap;
      }
      return newAddresses;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Vị trí ATM, chi nhánh')),
      ),
      body: _isLoading == true ? LoadingScreen() : ExpandableBottomSheet(
        key: key,
        onIsContractedCallback: () => print('contracted'),
        onIsExtendedCallback: () => print('extended'),
        animationDurationExtend: Duration(milliseconds: 500),
        animationDurationContract: Duration(milliseconds: 250),
        animationCurveExpand: Curves.bounceOut,
        animationCurveContract: Curves.ease,
        persistentContentHeight: 0, // do rong khi keo xuong

        background: Stack(
          children: [
            Positioned.fill(
                child: GoogleMap(
                  zoomControlsEnabled: false, // tat ban do
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    // target: LatLng(21.005536, 105.8180681),
                    target: LatLng(21.005536, 105.8180681),
                    zoom: 12,
                  ),
                  polylines: _polylines,
                  markers: markers,
                   onMapCreated: (GoogleMapController controller) {
                     _controller.complete(controller);
                     setState(() {
                       mapController = controller;
                     });
                   },
                )
            ),

            Positioned(
              top: kMinPadding,
              left: kMinPadding,
              child: Container(
                width: size.width -
                    (2 *
                        kMinPadding), // Sử dụng chiều rộng của màn hình trừ đi khoảng cách mép trái và phải
                child: SelectLocalWidget(
                  defaultHint: "Tỉnh/ Thành Phố",
                  selectedValue: provinceChose,
                  items: locations.keys.toList(),
                  onChanged: (value) async {
                    Map<String, District> newDistricts = await DioTest.postDistrict(locations[value]?.regionCode1 ?? "Hà Nội");
                    List<Map<String, BankLocation>>  newAddresses = await DioTest.postBranchATMTypeTwo
                      (_currentLocation.longitude.toString(), _currentLocation.latitude.toString(),locations[value]?.regionCode1 ?? "Hà Nội");
                    _polylines.clear();
                    //TODO fix provider
                    Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
                    await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
                    Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
                    setState(()  {
                      provinceChose = value;
                      districts = newDistricts;

                      address = newAddresses;
                      markers = setMarkers(0);
                    });

                  },
                  onValueChanged: (value) {
                    setState(() {
                      districtChose = null; // Reset giá trị của dopdown thứ hai khi dropdown thứ nhất thay đổi
                    });
                  },
                ),

              ),
            ),
            Positioned(
              top: kDefaultPadding * 2 +
                  40, // Đặt vị trí của SelectLocalWidget tiếp theo
              left: kMinPadding,
              width: size.width -
                  (2 * kMinPadding), // Đặt chiều rộng cho SelectLocalWidget
              child: SelectLocalWidget(
                defaultHint: "Quận/ Huyện",
                selectedValue: districtChose,
                items: districts.keys.toList(),
                onChanged: (value) async {
                  List<Map<String, BankLocation>> newAddresses = await DioTest.postBranchATMTypeThree
                    (_currentLocation.longitude.toString(), _currentLocation.latitude.toString(),
                      locations[provinceChose]?.regionCode1 ?? "101", districts[value]?.districtCode ?? "10111");
                  Provider.of<DialogProvider>(context, listen: false).showLoadingDialog(context);
                  await Future.delayed(Duration(milliseconds: 400)); // Đợi trong 2 giây
                  Provider.of<DialogProvider>(context, listen: false).hideLoadingDialog(context);
                  setState(() {
                    districtChose = value;
                    index = 1;
                    address = newAddresses;
                    markers = setMarkers(index);
                  });
                },
              ),
            ),
          ],
        ),

        persistentHeader: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                    backgroundColor: Colors.white60,
                  mini: true,
                  foregroundColor: Colors.black,
                    elevation: 4,
                  onPressed: () {
                    if (mapController != null) {
                      mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(21.005536, 105.8180681)));
                    }
                  },
                  child: Icon(FontAwesomeIcons.locationArrow),
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF19226D),
                      const Color(0xFFED1C24),
                    ],
                    stops: [0.5, 1],
                  )),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Expanded(child: _buildButton('Gần Nhất', () async{
                        //TODO tam thoi fix call
                        try{
                          List<Map<String, BankLocation>> newAddresses = await DioTest.
                          postBranchATMTypeOne(_currentLocation.longitude.toString(), _currentLocation.latitude.toString());
                          createCustomMarker();
                          setState(() {
                            index = 0;
                            address = address = sortMap(newAddresses);;
                            markers = setMarkers(0); // Cập nhật lại markers khi danh sách address được cập nhật
                          });
                        }catch(e){
                          index = 0;
                          print("Loi duoc goi $e");
                        }

                        // print(address[0].isEmpty && address[1].isEmpty);
                      }, 0)),
                      Expanded(child: _buildButton('ATM', () async {
                        if(provinceChose != null){
                          String regionCode1 = locations[provinceChose]?.regionCode1 ?? "101";
                          List<Map<String, BankLocation>>  newAddresses = await DioTest.
                          postBranchATMTypeTwo(_currentLocation.longitude.toString(), _currentLocation.latitude.toString(),regionCode1);
                          createCustomMarker();
                          setState(() {
                            index = 0;
                            address = sortMap(newAddresses);
                            markers = setMarkers(index); // Cập nhật lại markers khi danh sách address được cập nhật
                          });
                        }else{
                          setState(() {
                            index = 0;
                            markers = setMarkers(index); // Cập nhật lại markers khi danh sách address được cập nhật
                          });
                        }

                      }, 1)),
                      Expanded(child: _buildButton('Chi Nhánh', () async {
                        if(districtChose != null){
                          String regionCode1 = locations[provinceChose]?.regionCode1 ?? "101";
                          String districtCode = districts[districtChose]?.districtCode ?? '10111';
                          List<Map<String, BankLocation>> newAddresses =
                          await DioTest.postBranchATMTypeThree(_currentLocation.longitude.toString(), _currentLocation.latitude.toString(),
                              regionCode1, districtCode) ;
                          createCustomMarker();
                          setState(() {
                            index = 1;
                            address = address = sortMap(newAddresses);
                            markers = setMarkers(index); // Cập nhật lại markers khi danh sách address được cập nhật
                          });
                        }else{
                          setState(() {
                            index = 1;
                            markers = setMarkers(index); // Cập nhật lại markers khi danh sách address được cập nhật
                          });
                        }

                      }, 2)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        expandableContent: Container(
            constraints: const BoxConstraints.expand(height: 400), // do rong khi keo len
            decoration: const BoxDecoration(
              color: Colors.white,),
            child: ListView(
              controller: scrollController,
              children:  (!address[index].isEmpty) ? address[(index != 0 || index
               != 1) ? index : 0].entries.map((e) {
                 print(address.isEmpty);
                return GestureDetector(
                  onTap: () {
                    //TODO dang lay gt default
                    //     _createPolylines(LatLng(21.005536, 105.8180681), LatLng(double.parse(e.value.latitude), double.parse(e.value.longitude)));
                        _createPolylines(_currentLocation, LatLng(double.parse(e.value.latitude), double.parse(e.value.longitude)));
                  },
                  child: AddressFormWidget(
                    icon: (e.value.idImage == 'atm00') ? AssetPath.icoChiNhanhSo : AssetPath.icoSo,
                    title: e.value.shotName,
                    description: e.key.toString(),
                    distance: Geolocator.distanceBetween(_currentLocation.latitude, _currentLocation.longitude, double.parse(e.value.latitude), double.parse(e.value.longitude)),
                    distancePoint: DistancePoint(_currentLocation.latitude, _currentLocation.longitude, double.parse(e.value.latitude), double.parse(e.value.longitude)),
                  ),
                );
              }).toList() : [Center(child:Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text("Không có ATM/ Chi nhánh tại khu vực này", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),)],
            )
        ),
      ),
    );
  }

  Widget _buildButton(String title, VoidCallback onPressed, int index){

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButtonIndex = index; // Cập nhật nút được chọn
        });
        onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300), // Thời gian chuyển đổi
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: index == selectedButtonIndex ? Colors.grey.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? Radius.circular(20) : Radius.zero,
            topRight: index == 2 ? Radius.circular(20) : Radius.zero,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 12, color: index == selectedButtonIndex ? Colors.white : Colors.white60),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> getLocationUpdate() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if(_serviceEnabled){
      _serviceEnabled = await _locationController.requestService();
    }else{
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await _locationController.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return;
      }
    }
    _locationController.onLocationChanged.listen((LocationData currentLocationData) {
      if(currentLocationData.latitude != null && currentLocationData.longitude != null){
        setState(() {
          _currentLocation = LatLng(currentLocationData.latitude!, currentLocationData.longitude!);
          print('toa ho hien tai la $_currentLocation');
          setState(() {
            markers.add(
                Marker(
                  markerId: MarkerId("current01"),
                  // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentLocation ?? LatLng(21.005536, 105.8180681),
                )
            );
          });
        });
      }
    }
    );
  }


}
