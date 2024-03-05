import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/representation/widgets/select_item_widget.dart';

import '../../core/constants/dimension_constants.dart';
import '../widgets/select_local_widget.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Vị trí ATM, chi nhánh')),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(AssetPath.map, fit: BoxFit.cover,)
          ),
          Positioned(
            top: kMinPadding,
            left: kMinPadding,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(kItemPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding)),
                  color: Colors.white,
                ),
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 18,
                ),
              ),
            ),
          ),
          Positioned(
            top: kMediumPadding,
            left: kMinPadding,
            child: Container(
              width: size.width - (2 * kMinPadding), // Sử dụng chiều rộng của màn hình trừ đi khoảng cách mép trái và phải
              child: SelectLocalWidget(
                selectedValue: 'Tỉnh/ Thành Phố',
                items: ['Tỉnh/ Thành Phố', 'Thai Binh', 'Ha Noi'],
              ),
            ),
          ),
          Positioned(
            top: kMediumPadding * 2 + 40, // Đặt vị trí của SelectLocalWidget tiếp theo
            left: kMinPadding,
            width: size.width - (2 * kMinPadding), // Đặt chiều rộng cho SelectLocalWidget
            child: SelectLocalWidget(
              selectedValue: 'Quận huyện',
              items: ['Tỉnh/ Thành Phố', 'Quận huyện', 'Thai Binh', 'Ha Noi'],
            ),
          ),
        ],
      ),
    );
  }
}
