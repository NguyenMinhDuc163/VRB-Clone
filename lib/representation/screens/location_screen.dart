import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/representation/widgets/select_item_widget.dart';

import '../../core/constants/dimension_constants.dart';
import '../../models/district.dart';
import '../../models/province.dart';
import '../../models/viet_nam_locaton.dart';
import '../../network/netword_request.dart';
import '../widgets/acount_balancea_widget.dart';
import '../widgets/address_form_widget.dart';

import '../widgets/button_demo_widget.dart';
import '../widgets/rounded_buttom_widget.dart';
import '../widgets/select_local_widget.dart';
import 'package:location/location.dart';

import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Map<String, Province> locations = {};
   String provinceChose = 'Tỉnh/ Thành Phố';
   String districtChose = 'Quận/ Huyện';
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchData(); // Gọi fetchData khi trang được khởi tạo
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true; // Kích hoạt màn hình chờ
    });

    try {
      locations = await DioTest.postProviceInfoList();
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

    return  Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Vị trí ATM, chi nhánh')),
      ),
      body:_isLoading == true ? LoadingScreen() : Stack(
        children: [

          Positioned.fill(
              child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.005536, 105.8180681),
              zoom: 5,
            ),
            markers: { // them danh sach merker
              const Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(10.46425, 106.41252)),
              const Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(21.02206, 105.84805)),
              const Marker(
                  markerId: MarkerId("_currentLocation2"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(16.06061, 108.21437)),
              const Marker(
                  markerId: MarkerId("_currentLocation2"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(12.25141, 109.18795)),
            },
          )),




          Positioned(
            top: kMinPadding,
            left: kMinPadding,
            child: Container(
              width: size.width -
                  (2 *
                      kMinPadding), // Sử dụng chiều rộng của màn hình trừ đi khoảng cách mép trái và phải
              child: SelectLocalWidget(
                // selectedValue: 'Tỉnh/ Thành Phố',
                selectedValue: 'Tỉnh/ Thành Phố',
                items: locations.keys.toList(), onChanged: (String value) {
                  setState(() {
                    provinceChose = value;
                  });
                  print(provinceChose);
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
              selectedValue: 'Quận/ Huyện',
              // items: VietNamLocation.district,
              items: locations[provinceChose]!.Ddistrict.keys.toList(),
              onChanged: (String newValue){
                setState(() {
                  districtChose = newValue;
                  print(districtChose);
                });
              },
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            maxChildSize: 0.8,
            minChildSize: 0.3,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding * 2),
                    topRight: Radius.circular(kDefaultPadding * 2),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: kDefaultPadding),
                      child: Container(
                        height: 5,
                        width: 60,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(kItemPadding)),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    RoundedButtomWidget(
                      isSelected: false,
                      icon: Icons.macro_off,
                      onPressed: () {},
                    ),


                    Expanded(
                        child: ListView(
                      controller: scrollController,
                      children: const [
                        AddressFormWidget(
                          icon: AssetPath.icoChiNhanh,
                          title: 'Chi nhánh VRB sở giao dich',
                          description:
                              'Ngân hàng Liên doanh Việt - Nga - Chi nhánh Hồ Chí Minh, 107 Nguyễn Đình Chiểu, Phường 6, Quận 3, Thành phố Hồ Chí Minh, Việt Nam',
                        ),
                        AddressFormWidget(
                          icon: AssetPath.icoSo,
                          title: 'CHI NHANH SO GIAO DICH ',
                          description:
                              'Ngân hàng Liên doanh Việt - Nga - Chi nhánh Hồ Chí Minh, 107 Nguyễn Đình Chiểu, Phường 6, Quận 3, Thành phố Hồ Chí Minh, Việt Nam',
                        ),
                        AddressFormWidget(
                          icon: AssetPath.icoChiNhanhSo,
                          title: 'CHI NHANH SO GIAO DICH',
                          description:
                              'Ngân hàng Liên doanh Việt - Nga - Chi nhánh Hồ Chí Minh, 107 Nguyễn Đình Chiểu, Phường 6, Quận 3, Thành phố Hồ Chí Minh, Việt Nam',
                        ),
                      ],
                    ))
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
  // Future<void> getLocationUpdate() async { // lay vi tri nguoi dung
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //
  //   _serviceEnabled = await _locationController.serviceEnabled();
  //   if(_serviceEnabled){
  //     _serviceEnabled = await _locationController.requestService();
  //   }else{
  //     return;
  //   }
  //
  //   _permissionGranted = await _locationController.hasPermission();
  //   if(_permissionGranted == PermissionStatus.denied){
  //     _permissionGranted = await _locationController.requestPermission();
  //     if(_permissionGranted != PermissionStatus.granted){
  //       return;
  //     }
  //   }
  //   _locationController.onLocationChanged.listen((LocationData currentLocation) {
  //     if(currentLocation.longitude != null && currentLocation.latitude != null){
  //       setState(() {
  //         _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //         print(_currentP);
  //       });
  //
  //     }
  //   });
  // }


}
