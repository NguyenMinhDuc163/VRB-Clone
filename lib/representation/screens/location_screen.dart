import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/representation/widgets/select_item_widget.dart';

import '../../core/constants/dimension_constants.dart';
import '../widgets/address_form_widget.dart';
import '../widgets/location_branch_widget.dart';
import '../widgets/rounded_buttom_widget.dart';
import '../widgets/select_local_widget.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Vị trí ATM, chi nhánh')),
      ),
      body: Stack(
        children: [
          // Positioned.fill(
          //     child: Image.asset(
          //   AssetPath.map,
          //   fit: BoxFit.cover,
          // )),
          Positioned.fill(
              child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pGooglePlex,
              zoom: 5,
            ),
            markers: { // them danh sach merker
              Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pGooglePlex),
              Marker(
                  markerId: MarkerId("_currentLocation2"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(40.4223, -122.0848)),
              Marker(
                  markerId: MarkerId("_currentLocation2"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(45.4223, -122.0848)),
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
                selectedValue: 'Tỉnh/ Thành Phố',
                items: ['Tỉnh/ Thành Phố', 'Thai Binh', 'Ha Noi'],
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
              selectedValue: 'Quận huyện',
              items: ['Tỉnh/ Thành Phố', 'Quận huyện', 'Thai Binh', 'Ha Noi'],
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
}
