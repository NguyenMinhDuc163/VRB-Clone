import 'package:flutter/material.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/representation/screens/contact_helper.dart';
import 'package:vrb_client/representation/screens/exchange_rate_screen.dart';
import 'package:vrb_client/representation/screens/interest_screen.dart';
import 'package:vrb_client/representation/screens/location_screen.dart';
import 'package:vrb_client/representation/screens/qr_code_screen.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 110,
      // width: 360,
      constraints: BoxConstraints(// keo dân kichg thuoc
        maxWidth: MediaQuery.of(context).size.width,
      ),
      padding: EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetPath.buttomMenu), // Đường dẫn của ảnh nền
          fit: BoxFit.cover, // Đảm bảo ảnh nền phủ đầy container
        ),
      ),
      child: Row(
        children: [
          _buildIcon(AssetPath.tiGia, "Tỉ giá", (){
            Navigator.of(context).pushNamed(ExchangeRateScreen.routeName);
          }),
          _buildIcon(AssetPath.laiSuat, "Lãi xuất", (){
            Navigator.of(context).pushNamed(InterestScreen.routeName);
          }),
          _buildIcon(AssetPath.icoQR, "", (){
            Navigator.of(context).pushNamed(QRCodeScreen.routeName);
          }),
          _buildIcon(AssetPath.icoMap, "Mạng lưới", color: Colors.blue.shade900, (){
            Navigator.of(context).pushNamed(LocationScreen.routeName);
          }),
          _buildIcon(AssetPath.headPhone, "Liên hệ", (){
            Navigator.of(context).pushNamed(ContactHelper.routeName);
          }),
        ],
      ),
    );
  }

  Widget _buildIcon(String icon, String name, VoidCallback onTap, {Color? color}) {
    return Expanded(
      child: InkWell(
        onTap: onTap, // Sử dụng tham số onTap như là hàm được gọi khi InkWell được nhấn
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, color: color,),
            Text(name),
          ],
        ),
      ),
    );
  }

}
