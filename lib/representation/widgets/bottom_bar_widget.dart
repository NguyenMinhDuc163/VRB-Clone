import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/representation/screens/contact_helper.dart';
import 'package:vrb_client/representation/screens/exchange_rate_screen.dart';
import 'package:vrb_client/representation/screens/interest_screen.dart';
import 'package:vrb_client/representation/screens/location_screen.dart';
import 'package:vrb_client/representation/screens/qr_code_screen.dart';

import '../../generated/locale_keys.g.dart';
import '../../provider/selection_provider.dart';

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
          _buildIcon(AssetPath.tiGia, LocaleKeys.exchangeRate.tr(), (){
            Navigator.of(context).pushNamed(ExchangeRateScreen.routeName);
          }),
          _buildIcon(AssetPath.laiSuat, LocaleKeys.interestRate.tr(), (){
            Provider.of<SelectionProvider>(context, listen: false)
                .setData(LocaleKeys.typeProduct1.tr());
            Navigator.of(context).pushNamed(InterestScreen.routeName);
          }),
          _buildIcon(AssetPath.icoQR, "", (){
            Navigator.of(context).pushNamed(QRCodeScreen.routeName);
          }),
          _buildIcon(AssetPath.icoMap, LocaleKeys.network.tr(), color: Colors.blue.shade900, (){
            Navigator.of(context).pushNamed(LocationScreen.routeName);
          }),
          _buildIcon(AssetPath.headPhone, LocaleKeys.contact.tr(), (){
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
            Text(name, textAlign: TextAlign.center, style: TextStyle(fontSize: 14),),
          ],
        ),
      ),
    );
  }

}
