

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../core/constants/assets_path.dart';
import '../../core/constants/dimension_constants.dart';
import '../../models/bank_location.dart';
import '../../models/distance_point.dart';
import '../../models/district.dart';
import '../../models/province.dart';
import '../../network/netword_request.dart';
import '../widgets/address_form_widget.dart';
import '../widgets/select_local_widget.dart';
import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
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

  void initState() {
    super.initState();
    fetchData(); // Gọi fetchData khi trang được khởi tạo
    getLocationUpdate();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true; // Kích hoạt màn hình chờ
    });

    try {
      locations = await DioTest.postProvinceInfoList();
      address = await DioTest.postBranchATMTypeOne(_currentLocation.longitude.toString(), _currentLocation.latitude.toString());
    } catch (error) {
      // Xử lý lỗi ở đây
    }

    setState(() {
      _isLoading = false; // Tắt màn hình chờ
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ScrollController scrollController = ScrollController();
    Set<Marker> setMarkers(int index) {
      Set<Marker> markers = {};
      int markerIdCounter = 0;



      address[index].forEach((key, value) {
        double latitude = double.parse(value.latitude);
        double longitude = double.parse(value.longitude);
        print('${value.latitude}  ${value.longitude}');
        Marker marker = Marker(
          markerId: MarkerId("location$markerIdCounter"),
          position: LatLng(latitude, longitude),
        );

        markers.add(marker);
        markerIdCounter++;
      });

      return markers;
    }

    double distanceBetween(String latitude, String longitude){
      return Geolocator.distanceBetween
        (_currentLocation.latitude, _currentLocation.longitude, double.parse(latitude), double.parse(longitude));
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
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(21.005536, 105.8180681),
                    zoom: 13,
                  ),
                  markers: markers,
                   onMapCreated: (controller) {
                     setState(() {
                       mapController = controller;
                     });
                   },
                )
            ),

            Positioned(
              top: 200,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () {
                  if (mapController != null) {
                    mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(21.005536, 105.8180681)));
                  }
                },
                child: Icon(Icons.location_searching),
              ),
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
                    setState(()  {
                      provinceChose = value;
                      districts = newDistricts;
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
                onChanged: (value) {
                  setState(() {
                    districtChose = value;
                  });
                  print(districtChose);
                },
              ),
            ),
          ],
        ),

        persistentHeader: Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF19226D).withOpacity(0.9),
                  const Color(0xFFED1C24).withOpacity(0.8),
                ],
                stops: [0.5, 1],
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(child: _buildButton('Gần Nhất', () async{
                List<Map<String, BankLocation>> newAddresses = await DioTest.postBranchATMTypeOne(_currentLocation.longitude.toString(), _currentLocation.latitude.toString());
                for(int i = 0; i < newAddresses.length; i++){
                  List<MapEntry<String, BankLocation>> entries = newAddresses[i].entries.toList();
                  entries.sort((a, b) => distanceBetween(a.value.latitude, a.value.longitude).compareTo(distanceBetween(b.value.latitude, b.value.longitude)));
                  Map<String, BankLocation> sortedMap = Map.fromEntries(entries);
                  newAddresses[i] = sortedMap;
                }
                setState(() {
                  index = 0;
                  address = newAddresses;
                  markers = setMarkers(0); // Cập nhật lại markers khi danh sách address được cập nhật
                });
              }, 0)),
              Expanded(child: _buildButton('ATM', () async {
                if(provinceChose != null){
                  String regionCode1 = locations[provinceChose]?.regionCode1 ?? "805";
                  List<Map<String, BankLocation>>  newAddresses = await DioTest.postBranchATMTypeTwo(_currentLocation.longitude.toString(), _currentLocation.latitude.toString(),regionCode1);
                  setState(() {
                    index = 0;
                    address = newAddresses;
                    markers = setMarkers(index); // Cập nhật lại markers khi danh sách address được cập nhật
                  });
                }else{
                  setState(() {
                    // address = newAddresses;
                    markers = setMarkers(index); // Cập nhật lại markers khi danh sách address được cập nhật
                  });
                }

              }, 1)),
              Expanded(child: _buildButton('Chi Nhánh', () async {
                if(districtChose != null){
                  String regionCode1 = locations[provinceChose]?.regionCode1 ?? "101";
                  String districtCode = districts[districtChose]?.districtCode ?? '10111';

                  List<Map<String, BankLocation>> newAddresses = await DioTest.postBranchATMTypeThree(_currentLocation.longitude.toString(), _currentLocation.latitude.toString(), regionCode1, districtCode);
                  setState(() {
                    index = 1;
                    address = newAddresses;
                    markers = setMarkers(index); // Cập nhật lại markers khi danh sách address được cập nhật
                  });
                }else{
                  setState(() {
                    index = 1;
                    // address = newAddresses;
                    markers = setMarkers(index); // Cập nhật lại markers khi danh sách address được cập nhật
                  });
                }

              }, 2)),
            ],
          ),
        ),
        expandableContent: Container(
            constraints: BoxConstraints.expand(height: 400), // do rong khi keo len
            decoration: BoxDecoration(
              color: Colors.white,),
            child: ListView(
              controller: scrollController,
              children:  address[index].entries.map((e)  => AddressFormWidget(
                icon: (e.value.idImage == 'atm00') ? AssetPath.icoChiNhanhSo : AssetPath.icoSo,
                title: e.value.shotName,
                // LatLng(21.005536, 105.8180681)
                description: e.key.toString(), distance: Geolocator.distanceBetween
                (_currentLocation.latitude, _currentLocation.longitude, double.parse(e.value.latitude), double.parse(e.value.longitude)),
                distancePoint: DistancePoint(_currentLocation.latitude, _currentLocation.longitude, double.parse(e.value.latitude), double.parse(e.value.longitude)), // Sử dụng e.value để lấy giá trị từ map
              ),
              ).toList(),
            )
        ),
      ),
    );
  }

  Widget _buildButton(String title, VoidCallback onPressed, int index){

    return ElevatedButton(
      onPressed: (){
        setState(() {
          selectedButtonIndex = index; // Cập nhật nút được chọn
        });
        print(selectedButtonIndex);
        onPressed();
      },
      // onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor:index == selectedButtonIndex ? Colors.grey.withOpacity(0.3) : Colors.transparent, // Đổi màu nền ở đây
          padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10), // Có thể thêm các thuộc tính khác nếu cần
          shape: RoundedRectangleBorder(
            // Tạo hình dạng chữ nhật
            borderRadius: BorderRadius.circular(8),
          )
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 12,color:index == selectedButtonIndex ? Colors.white : Colors.white60,),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
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
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                  // position: _currentLocation ?? LatLng(21.005536, 105.8180681),
                  position: LatLng(21.005536, 105.8180681),
                )
            );
          });
        });
      }
    }
    );

  }


}
