import 'package:flutter/material.dart';
import 'package:vrb_client/core/constants/dimension_constants.dart';

import '../../../core/constants/assets_path.dart';

class ListBankHistoryWidget extends StatefulWidget {
  const ListBankHistoryWidget({super.key});

  @override
  State<ListBankHistoryWidget> createState() => _ListBankHistoryWidgetState();
}

class _ListBankHistoryWidgetState extends State<ListBankHistoryWidget> {

  final List<String> imagePaths = [
    AssetPath.logoBank1,
    AssetPath.logoBank2,
    AssetPath.logoBank3,
    AssetPath.logoBank4,
    AssetPath.logoBank5,
    AssetPath.logoBank6,
  ];

  Widget _buildHistoryExchange(String image, String name, String accountNum, String bankName){
    return Row(
      children: [
        SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(image)),
        SizedBox(width: kDefaultPadding,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 3,),
            Text(accountNum),
            SizedBox(height: 3,),
            Text(bankName, style: TextStyle(color: Colors.grey.shade500),),
          ],
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Đặt chiều cao cho container
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2), // Giảm kích thước padding để làm cho các icon gần nhau hơn
            child: Column(
              children: [
                _buildHistoryExchange(imagePaths[index], 'Nguyen Van A', '123456789123', 'VRB'),
                SizedBox(height: kDefaultPadding,),
              ],
            ),
          );
        },
      ),
    );
  }
}
